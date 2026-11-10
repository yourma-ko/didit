package com.andluck.didit

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

class HabitReminderReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        try {
            val scheduler = HabitReminderScheduler(context)
            if (intent.action == HabitReminderScheduler.FIRE) {
                scheduler.fire(intent.getIntExtra("id", -1), intent.getLongExtra("at", 0))
            } else {
                // Also runs without a Flutter engine after reboot, app upgrade,
                // manual clock/timezone changes and exact-alarm permission grant.
                scheduler.reschedule()
            }
        } catch (error: Exception) {
            Log.e("HabitReminders", "Could not restore habit alarms", error)
        }
    }
}
