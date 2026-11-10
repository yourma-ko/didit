package com.andluck.didit

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.provider.Settings
import org.json.JSONArray

class MainActivity: FlutterActivity() {
    private var permissionResult: MethodChannel.Result? = null
    private var channel: MethodChannel? = null
    private var pendingTrackerId: Int? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        pendingTrackerId = if (intent.hasExtra("trackerId")) intent.getIntExtra("trackerId", -1) else null
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.andluck.didit/reminders")
        channel!!.setMethodCallHandler { call, result ->
            val scheduler = HabitReminderScheduler(this)
            try {
                when (call.method) {
                    "replace" -> { scheduler.replace(JSONArray(call.arguments as List<*>)); result.success(null) }
                    "status" -> result.success(mapOf("notifications" to scheduler.notificationsAllowed(), "exact" to scheduler.exactAllowed()))
                    "requestPermission" -> {
                        if (Build.VERSION.SDK_INT >= 33 && checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) {
                            if (permissionResult != null) result.error("busy", "Permission request in progress", null)
                            else {
                                permissionResult = result
                                requestPermissions(arrayOf(Manifest.permission.POST_NOTIFICATIONS), 401)
                            }
                        } else result.success(scheduler.notificationsAllowed())
                    }
                    "notificationSettings" -> {
                        if (Build.VERSION.SDK_INT >= 26) {
                            startActivity(Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS).putExtra(Settings.EXTRA_APP_PACKAGE, packageName))
                        } else {
                            startActivity(Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:$packageName")))
                        }
                        result.success(null)
                    }
                    "exactAlarmSettings" -> {
                        if (Build.VERSION.SDK_INT >= 31 && !scheduler.exactAllowed()) {
                            startActivity(Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM, Uri.parse("package:$packageName")))
                        }
                        result.success(null)
                    }
                    "takeLaunchTracker" -> { result.success(pendingTrackerId); pendingTrackerId = null }
                    else -> result.notImplemented()
                }
            } catch (error: Exception) {
                result.error("reminder_error", error.message, null)
            }
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == 401) {
            permissionResult?.success(HabitReminderScheduler(this).notificationsAllowed())
            permissionResult = null
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        if (intent.hasExtra("trackerId")) {
            pendingTrackerId = intent.getIntExtra("trackerId", -1)
            channel?.invokeMethod("openTracker", pendingTrackerId)
            pendingTrackerId = null
        }
    }
}
