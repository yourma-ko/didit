import 'package:flutter/material.dart';
import 'habit_reminder.dart';
import 'reminder_platform.dart';

class ReminderFields extends StatefulWidget {
  final HabitReminder value;
  final ValueChanged<HabitReminder> onChanged;

  const ReminderFields(
      {super.key, required this.value, required this.onChanged});

  @override
  State<ReminderFields> createState() => _ReminderFieldsState();
}

class _ReminderFieldsState extends State<ReminderFields>
    with WidgetsBindingObserver {
  Map<String, dynamic> _status = {};
  String? _error;
  bool _requesting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refreshStatus();
  }

  Future<void> _refreshStatus() async {
    try {
      final status = await ReminderPlatform.status();
      if (mounted) {
        setState(() {
          _status = status;
          _error = null;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _error = 'Could not check reminder permissions.');
      }
    }
  }

  Future<void> _toggle(bool enabled) async {
    setState(() => _requesting = true);
    try {
      if (enabled) await ReminderPlatform.requestPermission();
      if (!mounted) return;
      _change(enabled: enabled);
      await _refreshStatus();
    } catch (_) {
      if (mounted) {
        setState(() => _error = 'Could not enable reminders. Try again.');
      }
    } finally {
      if (mounted) setState(() => _requesting = false);
    }
  }

  void _change({bool? enabled, TimeOfDay? time, Set<int>? days}) {
    widget.onChanged(HabitReminder(
      enabled: enabled ?? widget.value.enabled,
      hour: time?.hour ?? widget.value.hour,
      minute: time?.minute ?? widget.value.minute,
      weekdays: days ?? widget.value.weekdays,
    ));
  }

  Future<void> _openSettings(Future<void> Function() open) async {
    try {
      await open();
    } catch (_) {
      if (mounted) setState(() => _error = 'Could not open Android settings.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.value;
    if (!ReminderPlatform.isSupported) {
      return const Text('Local reminders are available in the Android app.');
    }
    final time = TimeOfDay(hour: value.hour, minute: value.minute);
    final labels = MaterialLocalizations.of(context).narrowWeekdays;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Reminder'),
        subtitle: const Text('At the selected time in your current timezone'),
        value: value.enabled,
        onChanged: _requesting ? null : _toggle,
      ),
      if (_error != null)
        Text(_error!,
            style: TextStyle(color: Theme.of(context).colorScheme.error)),
      if (value.enabled) ...[
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.schedule),
          title: const Text('Time'),
          trailing: Text(time.format(context)),
          onTap: () async {
            final picked =
                await showTimePicker(context: context, initialTime: time);
            if (picked != null && mounted) _change(time: picked);
          },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Every day'),
          value: value.weekdays.length == 7,
          onChanged: (daily) => _change(
              days: daily ? {1, 2, 3, 4, 5, 6, 7} : {DateTime.now().weekday}),
        ),
        Wrap(spacing: 8, children: [
          for (var day = 1; day <= 7; day++)
            FilterChip(
              label: Text(labels[day % 7]),
              tooltip: const [
                'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday',
                'Saturday',
                'Sunday'
              ][day - 1],
              selected: value.weekdays.contains(day),
              onSelected: (selected) {
                final days = {...value.weekdays};
                selected ? days.add(day) : days.remove(day);
                if (days.isNotEmpty) _change(days: days);
              },
            ),
        ]),
        const SizedBox(height: 8),
        const Text(
            'Choose at least one day. This does not change the habit period.'),
        if (_status['notifications'] == false) ...[
          const Text(
              'Notifications are blocked in Android settings. Your schedule will be saved.'),
          TextButton(
              onPressed: () =>
                  _openSettings(ReminderPlatform.openNotificationSettings),
              child: const Text('Allow notifications')),
        ],
        if (_status['exact'] == false) ...[
          const Text(
              'Android may delay reminders. Allow exact alarms for more precise timing.'),
          TextButton(
              onPressed: () =>
                  _openSettings(ReminderPlatform.openExactAlarmSettings),
              child: const Text('Allow exact alarms')),
        ],
      ],
    ]);
  }
}
