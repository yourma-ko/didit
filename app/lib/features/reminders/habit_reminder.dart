import 'dart:convert';

/// Wall-clock time in the device's current timezone; weekdays use ISO 1–7.
class HabitReminder {
  final bool enabled;
  final int hour;
  final int minute;
  final Set<int> weekdays;

  HabitReminder({
    this.enabled = false,
    this.hour = 9,
    this.minute = 0,
    Set<int> weekdays = const {1, 2, 3, 4, 5, 6, 7},
  }) : weekdays = Set.unmodifiable(weekdays) {
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59 ||
        weekdays.isEmpty || weekdays.any((day) => day < 1 || day > 7)) {
      throw const FormatException('Invalid habit reminder schedule');
    }
  }

  factory HabitReminder.fromJson(Map<String, dynamic> json) => HabitReminder(
        enabled: json['enabled'] as bool,
        hour: json['hour'] as int,
        minute: json['minute'] as int,
        weekdays: (json['weekdays'] as List).cast<int>().toSet(),
      );

  factory HabitReminder.decode(String? value) => value == null
      ? HabitReminder()
      : HabitReminder.fromJson(jsonDecode(value) as Map<String, dynamic>);

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'hour': hour,
        'minute': minute,
        'weekdays': weekdays.toList()..sort(),
      };

  String encode() => jsonEncode(toJson());
}
