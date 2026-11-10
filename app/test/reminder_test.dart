import 'dart:convert';

import 'package:didit/db/database.dart';
import 'package:didit/features/reminders/habit_reminder.dart';
import 'package:didit/features/reminders/reminder_fields.dart';
import 'package:didit/features/reminders/reminder_platform.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('old habits default to disabled daily reminders', () {
    final reminder = HabitReminder.decode(null);
    expect(reminder.enabled, false);
    expect(reminder.weekdays, {1, 2, 3, 4, 5, 6, 7});
  });

  test('schedule round-trips and rejects invalid imported data', () {
    final value =
        HabitReminder(enabled: true, hour: 23, minute: 59, weekdays: {5, 1});
    expect(HabitReminder.decode(value.encode()).toJson(), value.toJson());
    expect(() => HabitReminder(hour: 24), throwsFormatException);
    expect(() => HabitReminder(weekdays: {}), throwsFormatException);
    expect(() => HabitReminder(weekdays: {0, 8}), throwsFormatException);
    expect(() => HabitReminder(minute: -1), throwsFormatException);
  });

  group('database and Android delivery snapshot', () {
    late AppDatabase db;
    late List<List<dynamic>> snapshots;

    setUp(() {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      snapshots = [];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(ReminderPlatform.channel, (call) async {
        if (call.method == 'replace') {
          snapshots.add(call.arguments as List<dynamic>);
        }
        return null;
      });
      db = AppDatabase.forTesting(NativeDatabase.memory(),
          reminderDelivery: ReminderPlatform.replace);
    });

    tearDown(() async {
      await db.close();
      debugDefaultTargetPlatformOverride = null;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(ReminderPlatform.channel, null);
    });

    Future<int> insert({String type = 'habit'}) async {
      final now = DateTime(2026, 11, 10);
      return db.into(db.trackers).insert(TrackersCompanion.insert(
            name: 'Run',
            type: type,
            sortOrder: 1,
            createdAt: now,
            modifiedAt: now,
            habitReminder:
                Value(HabitReminder(enabled: true, weekdays: {1, 4}).encode()),
          ));
    }

    test('edit, disable, archive, restore and deletion replace pending alarms',
        () async {
      final id = await insert();
      await insert(type: 'goal');
      expect(await db.syncReminders(), true);
      expect(snapshots.last.single['id'], id);
      expect(snapshots.last.single['weekdays'], [1, 4]);
      await (db.update(db.trackers)..where((t) => t.id.equals(id)))
          .write(const TrackersCompanion(name: Value('Walk')));
      await db.syncReminders();
      expect(snapshots.last.single['title'], 'Walk');
      await db.setTrackerArchived(id, true);
      expect(snapshots.last, isEmpty);
      await db.setTrackerArchived(id, false);
      expect(snapshots.last, hasLength(1));
      await (db.update(db.trackers)..where((t) => t.id.equals(id))).write(
        TrackersCompanion(habitReminder: Value(HabitReminder().encode())),
      );
      await db.syncReminders();
      expect(snapshots.last, isEmpty);
      await db.deleteTrackerWithLogs(id);
      expect(snapshots.last, isEmpty);
    });

    test('backup restores schedules; old backup removes existing reminders',
        () async {
      await insert();
      final backup = await db.exportData();
      await db.importData(backup);
      expect(snapshots.last, hasLength(1));
      final old = jsonDecode(jsonEncode(backup)) as Map<String, dynamic>;
      for (final tracker in old['trackers'] as List) {
        (tracker as Map).remove('habitReminder');
      }
      await db.importData(old);
      expect(snapshots.last, isEmpty);
    });

    test('invalid imported reminder rolls back the whole import', () async {
      await insert();
      final backup = await db.exportData();
      (backup['trackers'] as List).first['habitReminder'] =
          '{"enabled":true,"hour":99,"minute":0,"weekdays":[1]}';
      await expectLater(db.importData(backup), throwsFormatException);
      expect(await db.select(db.trackers).get(), hasLength(1));
      expect(
          HabitReminder.decode(
                  (await db.select(db.trackers).getSingle()).habitReminder)
              .hour,
          9);
    });

    test('a failed platform write does not poison the next retry', () async {
      await insert();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(ReminderPlatform.channel, (_) async {
        throw PlatformException(code: 'unavailable');
      });
      expect(await db.syncReminders(), false);
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              ReminderPlatform.channel, (_) async => null);
      expect(await db.syncReminders(), true);
    });

    test('schema 4 upgrades without losing existing habits', () async {
      await db.close();
      final executor = NativeDatabase.memory(setup: (raw) {
        // Reuse the generated schema except the column introduced in version 5.
        raw.execute(
            'CREATE TABLE trackers (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, emoji TEXT, type TEXT NOT NULL, sort_order INTEGER NOT NULL, archived INTEGER NOT NULL DEFAULT 0, created_at INTEGER NOT NULL, modified_at INTEGER NOT NULL, habit_period TEXT, habit_value_options TEXT, habit_allow_multiple INTEGER, habit_freeze_enabled INTEGER, habit_freeze_earn_interval INTEGER, habit_freeze_limit INTEGER, habit_freeze_require_note INTEGER, habit_streak INTEGER, habit_longest_streak INTEGER, habit_freezes_available INTEGER, goal_unit TEXT, goal_target_amount REAL, goal_start_date INTEGER, goal_target_date INTEGER, goal_step_size REAL, goal_running_total REAL)');
        raw.execute(
            'CREATE TABLE logs (id INTEGER PRIMARY KEY AUTOINCREMENT, tracker_id INTEGER NOT NULL REFERENCES trackers(id), log_date TEXT NOT NULL, created_at INTEGER NOT NULL, modified_at INTEGER NOT NULL, value REAL, is_freeze INTEGER, note TEXT)');
        raw.execute(
            "INSERT INTO trackers (name, type, sort_order, created_at, modified_at) VALUES ('Existing habit', 'habit', 1, 0, 0)");
        raw.execute('PRAGMA user_version = 4');
      });
      db = AppDatabase.forTesting(executor);
      final habit = await db.select(db.trackers).getSingle();
      expect(habit.name, 'Existing habit');
      expect(habit.habitReminder, isNull);
      expect(HabitReminder.decode(habit.habitReminder).enabled, false);
    });
  });

  testWidgets('reminder UI preserves at least one selected day',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(ReminderPlatform.channel,
            (_) async => {'notifications': true, 'exact': true});
    var value = HabitReminder(enabled: true, weekdays: {1});
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: StatefulBuilder(
      builder: (context, setState) => ReminderFields(
          value: value, onChanged: (next) => setState(() => value = next)),
    ))));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilterChip).first);
    expect(value.weekdays, {1});
    await tester.tap(find.byType(FilterChip).at(3));
    await tester.pump();
    expect(value.weekdays, {1, 4});
    await tester.pumpWidget(const SizedBox());
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(ReminderPlatform.channel, null);
  });
}
