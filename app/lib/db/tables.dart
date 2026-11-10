// Design docs:
// - docs/design/data-model.md
// - docs/design/tech-stack.md

import 'package:drift/drift.dart';

class Trackers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get emoji => text().nullable()();
  TextColumn get type => text()(); // 'habit' | 'goal'
  IntColumn get sortOrder => integer()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get modifiedAt => dateTime()();

  // Habit-only config
  TextColumn get habitPeriod =>
      text().nullable()(); // 'daily' | 'weekly' | 'monthly'
  TextColumn get habitValueOptions =>
      text().nullable()(); // JSON array of label strings
  TextColumn get habitReminder => text().nullable()(); // JSON wall-clock schedule
  BoolColumn get habitAllowMultiple => boolean().nullable()();
  BoolColumn get habitFreezeEnabled => boolean().nullable()();
  IntColumn get habitFreezeEarnInterval => integer().nullable()();
  IntColumn get habitFreezeLimit => integer().nullable()();
  BoolColumn get habitFreezeRequireNote => boolean().nullable()();

  // Habit denormalized (recomputed from logs)
  IntColumn get habitStreak => integer().nullable()();
  IntColumn get habitLongestStreak => integer().nullable()();
  IntColumn get habitFreezesAvailable => integer().nullable()();

  // Goal-only config
  TextColumn get goalUnit => text().nullable()();
  RealColumn get goalTargetAmount => real().nullable()();
  DateTimeColumn get goalStartDate => dateTime().nullable()();
  DateTimeColumn get goalTargetDate => dateTime().nullable()();
  RealColumn get goalStepSize => real().nullable()();

  // Goal denormalized (recomputed from logs)
  RealColumn get goalRunningTotal => real().nullable()();
}

class Logs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get trackerId => integer().references(Trackers, #id)();
  TextColumn get logDate => text()(); // YYYY-MM-DD
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get modifiedAt => dateTime()();
  RealColumn get value => real().nullable()();
  BoolColumn get isFreeze => boolean().nullable()();
  TextColumn get note => text().nullable()();
}
