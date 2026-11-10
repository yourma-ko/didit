import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// The Android side owns durable alarms, permissions and timezone changes.
/// No Dart isolate or running Flutter engine is needed to deliver an alarm.
class ReminderPlatform {
  static const channel = MethodChannel('com.andluck.didit/reminders');
  static bool get isSupported =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static Future<void> replace(List<Map<String, dynamic>> reminders) async {
    if (isSupported) await channel.invokeMethod<void>('replace', reminders);
  }

  static Future<Map<String, dynamic>> status() async {
    if (!isSupported) return {};
    return Map<String, dynamic>.from(
        await channel.invokeMapMethod<String, dynamic>('status') ?? {});
  }

  static Future<bool> requestPermission() async => !isSupported
      ? false
      : await channel.invokeMethod<bool>('requestPermission') ?? false;

  static Future<void> openNotificationSettings() async {
    if (isSupported) await channel.invokeMethod<void>('notificationSettings');
  }

  static Future<void> openExactAlarmSettings() async {
    if (isSupported) await channel.invokeMethod<void>('exactAlarmSettings');
  }

  static Future<void> bindNotificationTap(Future<void> Function(int) open) async {
    if (!isSupported) return;
    channel.setMethodCallHandler((call) async {
      if (call.method == 'openTracker') await open(call.arguments as int);
    });
    final id = await channel.invokeMethod<int>('takeLaunchTracker');
    if (id != null) await open(id);
  }
}
