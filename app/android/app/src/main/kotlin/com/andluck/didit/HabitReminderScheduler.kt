package com.andluck.didit

import android.Manifest
import android.app.AlarmManager
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import org.json.JSONArray
import org.json.JSONObject
import java.time.Instant
import java.time.ZoneId

/** Durable Android delivery cache. The Flutter SQLite database owns settings. */
class HabitReminderScheduler(private val context: Context) {
    private val preferences = context.getSharedPreferences("habit_reminders", Context.MODE_PRIVATE)
    private val alarms = context.getSystemService(AlarmManager::class.java)
    private val notifications = context.getSystemService(NotificationManager::class.java)

    companion object {
        const val CHANNEL = "habit_reminders_v1"
        const val FIRE = "com.andluck.didit.HABIT_REMINDER"
    }

    fun ensureChannel() {
        if (Build.VERSION.SDK_INT >= 26) {
            notifications.createNotificationChannel(NotificationChannel(
                CHANNEL, "Habit reminders", NotificationManager.IMPORTANCE_DEFAULT
            ).apply { description = "Reminders for your habits" })
        }
    }

    fun notificationsAllowed(): Boolean {
        ensureChannel()
        if (Build.VERSION.SDK_INT >= 33 &&
            context.checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) {
            return false
        }
        if (!notifications.areNotificationsEnabled()) return false
        return Build.VERSION.SDK_INT < 26 ||
            notifications.getNotificationChannel(CHANNEL)?.importance != NotificationManager.IMPORTANCE_NONE
    }

    fun exactAllowed(): Boolean = Build.VERSION.SDK_INT < 31 || alarms.canScheduleExactAlarms()

    private fun snapshot(): List<JSONObject> {
        val array = JSONArray(preferences.getString("snapshot", "[]"))
        return (0 until array.length()).map { array.getJSONObject(it) }
    }

    fun replace(reminders: JSONArray) {
        // Validate everything before changing durable settings or existing alarms.
        val ids = mutableSetOf<Int>()
        for (index in 0 until reminders.length()) {
            val reminder = reminders.getJSONObject(index)
            val id = reminder.getInt("id")
            require(id > 0 && ids.add(id))
            require(reminder.getInt("hour") in 0..23 && reminder.getInt("minute") in 0..59)
            val days = reminder.getJSONArray("weekdays")
            require(days.length() in 1..7)
            for (day in 0 until days.length()) require(days.getInt(day) in 1..7)
            require(reminder.getString("title").isNotBlank())
        }
        val old = snapshot()
        // Commit before cancelling: a receiver queued for an old ID will find
        // the new snapshot and refuse to post a deleted/disabled habit.
        check(preferences.edit().putString("snapshot", reminders.toString()).commit())
        old.forEach {
            val id = it.getInt("id")
            alarms.cancel(alarmIntent(id))
            notifications.cancel("habit", id)
            if (id !in ids) preferences.edit().remove("next_$id").remove("last_$id").apply()
        }
        reschedule()
    }

    fun reschedule() {
        ensureChannel()
        snapshot().forEach { schedule(it) }
    }

    private fun alarmIntent(id: Int, at: Long = 0): PendingIntent = PendingIntent.getBroadcast(
        context, id,
        Intent(context, HabitReminderReceiver::class.java)
            .setAction(FIRE).putExtra("id", id).putExtra("at", at),
        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
    )

    private fun schedule(reminder: JSONObject) {
        val id = reminder.getInt("id")
        val days = reminder.getJSONArray("weekdays")
        val next = ReminderTime.next(
            Instant.now(), ZoneId.systemDefault(),
            reminder.getInt("hour"), reminder.getInt("minute"),
            (0 until days.length()).map { days.getInt(it) }.toSet(),
            preferences.getString("last_$id", null),
        ).toEpochMilli()
        check(preferences.edit().putLong("next_$id", next).commit())
        val intent = alarmIntent(id, next)
        try {
            if (exactAllowed()) {
                alarms.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, next, intent)
            } else {
                alarms.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, next, intent)
            }
        } catch (_: SecurityException) {
            // Exact-alarm access can be revoked between the check and the call.
            alarms.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, next, intent)
        }
    }

    fun fire(id: Int, at: Long) {
        val reminder = snapshot().firstOrNull { it.getInt("id") == id } ?: return
        if (at == 0L || preferences.getLong("next_$id", 0) != at) return
        val zone = ZoneId.systemDefault()
        val now = Instant.now()
        val scheduledDate = Instant.ofEpochMilli(at).atZone(zone).toLocalDate()
        val today = now.atZone(zone).toLocalDate()
        val last = preferences.getString("last_$id", null)
        // Do not emit yesterday's reminder after a long device shutdown/delay.
        val shouldPost = scheduledDate == today && last != today.toString()
        if (shouldPost) {
            check(preferences.edit().putString("last_$id", today.toString()).commit())
        }
        schedule(reminder) // Recurrence survives even if posting is blocked.
        if (!shouldPost || !notificationsAllowed()) return
        val open = PendingIntent.getActivity(
            context, id,
            Intent(context, MainActivity::class.java)
                .putExtra("trackerId", id)
                .addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
        val builder = if (Build.VERSION.SDK_INT >= 26) Notification.Builder(context, CHANNEL)
                      else Notification.Builder(context)
        val notification = builder
            .setSmallIcon(R.drawable.ic_stat_habit)
            .setContentTitle(reminder.getString("title"))
            .setContentText("Time for your habit")
            .setContentIntent(open)
            .setAutoCancel(true)
            .setCategory(Notification.CATEGORY_REMINDER)
            .build()
        try {
            notifications.notify("habit", id, notification)
        } catch (_: SecurityException) {
            // Permission may be revoked while the broadcast is being handled.
        }
    }
}
