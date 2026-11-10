// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TrackersTable extends Trackers with TableInfo<$TrackersTable, Tracker> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
      'emoji', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _archivedMeta =
      const VerificationMeta('archived');
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
      'archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _modifiedAtMeta =
      const VerificationMeta('modifiedAt');
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
      'modified_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _habitPeriodMeta =
      const VerificationMeta('habitPeriod');
  @override
  late final GeneratedColumn<String> habitPeriod = GeneratedColumn<String>(
      'habit_period', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _habitValueOptionsMeta =
      const VerificationMeta('habitValueOptions');
  @override
  late final GeneratedColumn<String> habitValueOptions =
      GeneratedColumn<String>('habit_value_options', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _habitReminderMeta =
      const VerificationMeta('habitReminder');
  @override
  late final GeneratedColumn<String> habitReminder = GeneratedColumn<String>(
      'habit_reminder', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _habitAllowMultipleMeta =
      const VerificationMeta('habitAllowMultiple');
  @override
  late final GeneratedColumn<bool> habitAllowMultiple = GeneratedColumn<bool>(
      'habit_allow_multiple', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("habit_allow_multiple" IN (0, 1))'));
  static const VerificationMeta _habitFreezeEnabledMeta =
      const VerificationMeta('habitFreezeEnabled');
  @override
  late final GeneratedColumn<bool> habitFreezeEnabled = GeneratedColumn<bool>(
      'habit_freeze_enabled', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("habit_freeze_enabled" IN (0, 1))'));
  static const VerificationMeta _habitFreezeEarnIntervalMeta =
      const VerificationMeta('habitFreezeEarnInterval');
  @override
  late final GeneratedColumn<int> habitFreezeEarnInterval =
      GeneratedColumn<int>('habit_freeze_earn_interval', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _habitFreezeLimitMeta =
      const VerificationMeta('habitFreezeLimit');
  @override
  late final GeneratedColumn<int> habitFreezeLimit = GeneratedColumn<int>(
      'habit_freeze_limit', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _habitFreezeRequireNoteMeta =
      const VerificationMeta('habitFreezeRequireNote');
  @override
  late final GeneratedColumn<bool> habitFreezeRequireNote =
      GeneratedColumn<bool>('habit_freeze_require_note', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("habit_freeze_require_note" IN (0, 1))'));
  static const VerificationMeta _habitStreakMeta =
      const VerificationMeta('habitStreak');
  @override
  late final GeneratedColumn<int> habitStreak = GeneratedColumn<int>(
      'habit_streak', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _habitLongestStreakMeta =
      const VerificationMeta('habitLongestStreak');
  @override
  late final GeneratedColumn<int> habitLongestStreak = GeneratedColumn<int>(
      'habit_longest_streak', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _habitFreezesAvailableMeta =
      const VerificationMeta('habitFreezesAvailable');
  @override
  late final GeneratedColumn<int> habitFreezesAvailable = GeneratedColumn<int>(
      'habit_freezes_available', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _goalUnitMeta =
      const VerificationMeta('goalUnit');
  @override
  late final GeneratedColumn<String> goalUnit = GeneratedColumn<String>(
      'goal_unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _goalTargetAmountMeta =
      const VerificationMeta('goalTargetAmount');
  @override
  late final GeneratedColumn<double> goalTargetAmount = GeneratedColumn<double>(
      'goal_target_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _goalStartDateMeta =
      const VerificationMeta('goalStartDate');
  @override
  late final GeneratedColumn<DateTime> goalStartDate =
      GeneratedColumn<DateTime>('goal_start_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _goalTargetDateMeta =
      const VerificationMeta('goalTargetDate');
  @override
  late final GeneratedColumn<DateTime> goalTargetDate =
      GeneratedColumn<DateTime>('goal_target_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _goalStepSizeMeta =
      const VerificationMeta('goalStepSize');
  @override
  late final GeneratedColumn<double> goalStepSize = GeneratedColumn<double>(
      'goal_step_size', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _goalRunningTotalMeta =
      const VerificationMeta('goalRunningTotal');
  @override
  late final GeneratedColumn<double> goalRunningTotal = GeneratedColumn<double>(
      'goal_running_total', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        emoji,
        type,
        sortOrder,
        archived,
        createdAt,
        modifiedAt,
        habitPeriod,
        habitValueOptions,
        habitReminder,
        habitAllowMultiple,
        habitFreezeEnabled,
        habitFreezeEarnInterval,
        habitFreezeLimit,
        habitFreezeRequireNote,
        habitStreak,
        habitLongestStreak,
        habitFreezesAvailable,
        goalUnit,
        goalTargetAmount,
        goalStartDate,
        goalTargetDate,
        goalStepSize,
        goalRunningTotal
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trackers';
  @override
  VerificationContext validateIntegrity(Insertable<Tracker> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('emoji')) {
      context.handle(
          _emojiMeta, emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('archived')) {
      context.handle(_archivedMeta,
          archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at']!, _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    if (data.containsKey('habit_period')) {
      context.handle(
          _habitPeriodMeta,
          habitPeriod.isAcceptableOrUnknown(
              data['habit_period']!, _habitPeriodMeta));
    }
    if (data.containsKey('habit_value_options')) {
      context.handle(
          _habitValueOptionsMeta,
          habitValueOptions.isAcceptableOrUnknown(
              data['habit_value_options']!, _habitValueOptionsMeta));
    }
    if (data.containsKey('habit_reminder')) {
      context.handle(
          _habitReminderMeta,
          habitReminder.isAcceptableOrUnknown(
              data['habit_reminder']!, _habitReminderMeta));
    }
    if (data.containsKey('habit_allow_multiple')) {
      context.handle(
          _habitAllowMultipleMeta,
          habitAllowMultiple.isAcceptableOrUnknown(
              data['habit_allow_multiple']!, _habitAllowMultipleMeta));
    }
    if (data.containsKey('habit_freeze_enabled')) {
      context.handle(
          _habitFreezeEnabledMeta,
          habitFreezeEnabled.isAcceptableOrUnknown(
              data['habit_freeze_enabled']!, _habitFreezeEnabledMeta));
    }
    if (data.containsKey('habit_freeze_earn_interval')) {
      context.handle(
          _habitFreezeEarnIntervalMeta,
          habitFreezeEarnInterval.isAcceptableOrUnknown(
              data['habit_freeze_earn_interval']!,
              _habitFreezeEarnIntervalMeta));
    }
    if (data.containsKey('habit_freeze_limit')) {
      context.handle(
          _habitFreezeLimitMeta,
          habitFreezeLimit.isAcceptableOrUnknown(
              data['habit_freeze_limit']!, _habitFreezeLimitMeta));
    }
    if (data.containsKey('habit_freeze_require_note')) {
      context.handle(
          _habitFreezeRequireNoteMeta,
          habitFreezeRequireNote.isAcceptableOrUnknown(
              data['habit_freeze_require_note']!, _habitFreezeRequireNoteMeta));
    }
    if (data.containsKey('habit_streak')) {
      context.handle(
          _habitStreakMeta,
          habitStreak.isAcceptableOrUnknown(
              data['habit_streak']!, _habitStreakMeta));
    }
    if (data.containsKey('habit_longest_streak')) {
      context.handle(
          _habitLongestStreakMeta,
          habitLongestStreak.isAcceptableOrUnknown(
              data['habit_longest_streak']!, _habitLongestStreakMeta));
    }
    if (data.containsKey('habit_freezes_available')) {
      context.handle(
          _habitFreezesAvailableMeta,
          habitFreezesAvailable.isAcceptableOrUnknown(
              data['habit_freezes_available']!, _habitFreezesAvailableMeta));
    }
    if (data.containsKey('goal_unit')) {
      context.handle(_goalUnitMeta,
          goalUnit.isAcceptableOrUnknown(data['goal_unit']!, _goalUnitMeta));
    }
    if (data.containsKey('goal_target_amount')) {
      context.handle(
          _goalTargetAmountMeta,
          goalTargetAmount.isAcceptableOrUnknown(
              data['goal_target_amount']!, _goalTargetAmountMeta));
    }
    if (data.containsKey('goal_start_date')) {
      context.handle(
          _goalStartDateMeta,
          goalStartDate.isAcceptableOrUnknown(
              data['goal_start_date']!, _goalStartDateMeta));
    }
    if (data.containsKey('goal_target_date')) {
      context.handle(
          _goalTargetDateMeta,
          goalTargetDate.isAcceptableOrUnknown(
              data['goal_target_date']!, _goalTargetDateMeta));
    }
    if (data.containsKey('goal_step_size')) {
      context.handle(
          _goalStepSizeMeta,
          goalStepSize.isAcceptableOrUnknown(
              data['goal_step_size']!, _goalStepSizeMeta));
    }
    if (data.containsKey('goal_running_total')) {
      context.handle(
          _goalRunningTotalMeta,
          goalRunningTotal.isAcceptableOrUnknown(
              data['goal_running_total']!, _goalRunningTotalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tracker map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tracker(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      emoji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}emoji']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      archived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}archived'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      modifiedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}modified_at'])!,
      habitPeriod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habit_period']),
      habitValueOptions: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}habit_value_options']),
      habitReminder: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habit_reminder']),
      habitAllowMultiple: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}habit_allow_multiple']),
      habitFreezeEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}habit_freeze_enabled']),
      habitFreezeEarnInterval: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}habit_freeze_earn_interval']),
      habitFreezeLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}habit_freeze_limit']),
      habitFreezeRequireNote: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}habit_freeze_require_note']),
      habitStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}habit_streak']),
      habitLongestStreak: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}habit_longest_streak']),
      habitFreezesAvailable: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}habit_freezes_available']),
      goalUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goal_unit']),
      goalTargetAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}goal_target_amount']),
      goalStartDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}goal_start_date']),
      goalTargetDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}goal_target_date']),
      goalStepSize: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}goal_step_size']),
      goalRunningTotal: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}goal_running_total']),
    );
  }

  @override
  $TrackersTable createAlias(String alias) {
    return $TrackersTable(attachedDatabase, alias);
  }
}

class Tracker extends DataClass implements Insertable<Tracker> {
  final int id;
  final String name;
  final String? emoji;
  final String type;
  final int sortOrder;
  final bool archived;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String? habitPeriod;
  final String? habitValueOptions;
  final String? habitReminder;
  final bool? habitAllowMultiple;
  final bool? habitFreezeEnabled;
  final int? habitFreezeEarnInterval;
  final int? habitFreezeLimit;
  final bool? habitFreezeRequireNote;
  final int? habitStreak;
  final int? habitLongestStreak;
  final int? habitFreezesAvailable;
  final String? goalUnit;
  final double? goalTargetAmount;
  final DateTime? goalStartDate;
  final DateTime? goalTargetDate;
  final double? goalStepSize;
  final double? goalRunningTotal;
  const Tracker(
      {required this.id,
      required this.name,
      this.emoji,
      required this.type,
      required this.sortOrder,
      required this.archived,
      required this.createdAt,
      required this.modifiedAt,
      this.habitPeriod,
      this.habitValueOptions,
      this.habitReminder,
      this.habitAllowMultiple,
      this.habitFreezeEnabled,
      this.habitFreezeEarnInterval,
      this.habitFreezeLimit,
      this.habitFreezeRequireNote,
      this.habitStreak,
      this.habitLongestStreak,
      this.habitFreezesAvailable,
      this.goalUnit,
      this.goalTargetAmount,
      this.goalStartDate,
      this.goalTargetDate,
      this.goalStepSize,
      this.goalRunningTotal});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || emoji != null) {
      map['emoji'] = Variable<String>(emoji);
    }
    map['type'] = Variable<String>(type);
    map['sort_order'] = Variable<int>(sortOrder);
    map['archived'] = Variable<bool>(archived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    if (!nullToAbsent || habitPeriod != null) {
      map['habit_period'] = Variable<String>(habitPeriod);
    }
    if (!nullToAbsent || habitValueOptions != null) {
      map['habit_value_options'] = Variable<String>(habitValueOptions);
    }
    if (!nullToAbsent || habitReminder != null) {
      map['habit_reminder'] = Variable<String>(habitReminder);
    }
    if (!nullToAbsent || habitAllowMultiple != null) {
      map['habit_allow_multiple'] = Variable<bool>(habitAllowMultiple);
    }
    if (!nullToAbsent || habitFreezeEnabled != null) {
      map['habit_freeze_enabled'] = Variable<bool>(habitFreezeEnabled);
    }
    if (!nullToAbsent || habitFreezeEarnInterval != null) {
      map['habit_freeze_earn_interval'] =
          Variable<int>(habitFreezeEarnInterval);
    }
    if (!nullToAbsent || habitFreezeLimit != null) {
      map['habit_freeze_limit'] = Variable<int>(habitFreezeLimit);
    }
    if (!nullToAbsent || habitFreezeRequireNote != null) {
      map['habit_freeze_require_note'] = Variable<bool>(habitFreezeRequireNote);
    }
    if (!nullToAbsent || habitStreak != null) {
      map['habit_streak'] = Variable<int>(habitStreak);
    }
    if (!nullToAbsent || habitLongestStreak != null) {
      map['habit_longest_streak'] = Variable<int>(habitLongestStreak);
    }
    if (!nullToAbsent || habitFreezesAvailable != null) {
      map['habit_freezes_available'] = Variable<int>(habitFreezesAvailable);
    }
    if (!nullToAbsent || goalUnit != null) {
      map['goal_unit'] = Variable<String>(goalUnit);
    }
    if (!nullToAbsent || goalTargetAmount != null) {
      map['goal_target_amount'] = Variable<double>(goalTargetAmount);
    }
    if (!nullToAbsent || goalStartDate != null) {
      map['goal_start_date'] = Variable<DateTime>(goalStartDate);
    }
    if (!nullToAbsent || goalTargetDate != null) {
      map['goal_target_date'] = Variable<DateTime>(goalTargetDate);
    }
    if (!nullToAbsent || goalStepSize != null) {
      map['goal_step_size'] = Variable<double>(goalStepSize);
    }
    if (!nullToAbsent || goalRunningTotal != null) {
      map['goal_running_total'] = Variable<double>(goalRunningTotal);
    }
    return map;
  }

  TrackersCompanion toCompanion(bool nullToAbsent) {
    return TrackersCompanion(
      id: Value(id),
      name: Value(name),
      emoji:
          emoji == null && nullToAbsent ? const Value.absent() : Value(emoji),
      type: Value(type),
      sortOrder: Value(sortOrder),
      archived: Value(archived),
      createdAt: Value(createdAt),
      modifiedAt: Value(modifiedAt),
      habitPeriod: habitPeriod == null && nullToAbsent
          ? const Value.absent()
          : Value(habitPeriod),
      habitValueOptions: habitValueOptions == null && nullToAbsent
          ? const Value.absent()
          : Value(habitValueOptions),
      habitReminder: habitReminder == null && nullToAbsent
          ? const Value.absent()
          : Value(habitReminder),
      habitAllowMultiple: habitAllowMultiple == null && nullToAbsent
          ? const Value.absent()
          : Value(habitAllowMultiple),
      habitFreezeEnabled: habitFreezeEnabled == null && nullToAbsent
          ? const Value.absent()
          : Value(habitFreezeEnabled),
      habitFreezeEarnInterval: habitFreezeEarnInterval == null && nullToAbsent
          ? const Value.absent()
          : Value(habitFreezeEarnInterval),
      habitFreezeLimit: habitFreezeLimit == null && nullToAbsent
          ? const Value.absent()
          : Value(habitFreezeLimit),
      habitFreezeRequireNote: habitFreezeRequireNote == null && nullToAbsent
          ? const Value.absent()
          : Value(habitFreezeRequireNote),
      habitStreak: habitStreak == null && nullToAbsent
          ? const Value.absent()
          : Value(habitStreak),
      habitLongestStreak: habitLongestStreak == null && nullToAbsent
          ? const Value.absent()
          : Value(habitLongestStreak),
      habitFreezesAvailable: habitFreezesAvailable == null && nullToAbsent
          ? const Value.absent()
          : Value(habitFreezesAvailable),
      goalUnit: goalUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(goalUnit),
      goalTargetAmount: goalTargetAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(goalTargetAmount),
      goalStartDate: goalStartDate == null && nullToAbsent
          ? const Value.absent()
          : Value(goalStartDate),
      goalTargetDate: goalTargetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(goalTargetDate),
      goalStepSize: goalStepSize == null && nullToAbsent
          ? const Value.absent()
          : Value(goalStepSize),
      goalRunningTotal: goalRunningTotal == null && nullToAbsent
          ? const Value.absent()
          : Value(goalRunningTotal),
    );
  }

  factory Tracker.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tracker(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      emoji: serializer.fromJson<String?>(json['emoji']),
      type: serializer.fromJson<String>(json['type']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      archived: serializer.fromJson<bool>(json['archived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
      habitPeriod: serializer.fromJson<String?>(json['habitPeriod']),
      habitValueOptions:
          serializer.fromJson<String?>(json['habitValueOptions']),
      habitReminder: serializer.fromJson<String?>(json['habitReminder']),
      habitAllowMultiple:
          serializer.fromJson<bool?>(json['habitAllowMultiple']),
      habitFreezeEnabled:
          serializer.fromJson<bool?>(json['habitFreezeEnabled']),
      habitFreezeEarnInterval:
          serializer.fromJson<int?>(json['habitFreezeEarnInterval']),
      habitFreezeLimit: serializer.fromJson<int?>(json['habitFreezeLimit']),
      habitFreezeRequireNote:
          serializer.fromJson<bool?>(json['habitFreezeRequireNote']),
      habitStreak: serializer.fromJson<int?>(json['habitStreak']),
      habitLongestStreak: serializer.fromJson<int?>(json['habitLongestStreak']),
      habitFreezesAvailable:
          serializer.fromJson<int?>(json['habitFreezesAvailable']),
      goalUnit: serializer.fromJson<String?>(json['goalUnit']),
      goalTargetAmount: serializer.fromJson<double?>(json['goalTargetAmount']),
      goalStartDate: serializer.fromJson<DateTime?>(json['goalStartDate']),
      goalTargetDate: serializer.fromJson<DateTime?>(json['goalTargetDate']),
      goalStepSize: serializer.fromJson<double?>(json['goalStepSize']),
      goalRunningTotal: serializer.fromJson<double?>(json['goalRunningTotal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'emoji': serializer.toJson<String?>(emoji),
      'type': serializer.toJson<String>(type),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'archived': serializer.toJson<bool>(archived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
      'habitPeriod': serializer.toJson<String?>(habitPeriod),
      'habitValueOptions': serializer.toJson<String?>(habitValueOptions),
      'habitReminder': serializer.toJson<String?>(habitReminder),
      'habitAllowMultiple': serializer.toJson<bool?>(habitAllowMultiple),
      'habitFreezeEnabled': serializer.toJson<bool?>(habitFreezeEnabled),
      'habitFreezeEarnInterval':
          serializer.toJson<int?>(habitFreezeEarnInterval),
      'habitFreezeLimit': serializer.toJson<int?>(habitFreezeLimit),
      'habitFreezeRequireNote':
          serializer.toJson<bool?>(habitFreezeRequireNote),
      'habitStreak': serializer.toJson<int?>(habitStreak),
      'habitLongestStreak': serializer.toJson<int?>(habitLongestStreak),
      'habitFreezesAvailable': serializer.toJson<int?>(habitFreezesAvailable),
      'goalUnit': serializer.toJson<String?>(goalUnit),
      'goalTargetAmount': serializer.toJson<double?>(goalTargetAmount),
      'goalStartDate': serializer.toJson<DateTime?>(goalStartDate),
      'goalTargetDate': serializer.toJson<DateTime?>(goalTargetDate),
      'goalStepSize': serializer.toJson<double?>(goalStepSize),
      'goalRunningTotal': serializer.toJson<double?>(goalRunningTotal),
    };
  }

  Tracker copyWith(
          {int? id,
          String? name,
          Value<String?> emoji = const Value.absent(),
          String? type,
          int? sortOrder,
          bool? archived,
          DateTime? createdAt,
          DateTime? modifiedAt,
          Value<String?> habitPeriod = const Value.absent(),
          Value<String?> habitValueOptions = const Value.absent(),
          Value<String?> habitReminder = const Value.absent(),
          Value<bool?> habitAllowMultiple = const Value.absent(),
          Value<bool?> habitFreezeEnabled = const Value.absent(),
          Value<int?> habitFreezeEarnInterval = const Value.absent(),
          Value<int?> habitFreezeLimit = const Value.absent(),
          Value<bool?> habitFreezeRequireNote = const Value.absent(),
          Value<int?> habitStreak = const Value.absent(),
          Value<int?> habitLongestStreak = const Value.absent(),
          Value<int?> habitFreezesAvailable = const Value.absent(),
          Value<String?> goalUnit = const Value.absent(),
          Value<double?> goalTargetAmount = const Value.absent(),
          Value<DateTime?> goalStartDate = const Value.absent(),
          Value<DateTime?> goalTargetDate = const Value.absent(),
          Value<double?> goalStepSize = const Value.absent(),
          Value<double?> goalRunningTotal = const Value.absent()}) =>
      Tracker(
        id: id ?? this.id,
        name: name ?? this.name,
        emoji: emoji.present ? emoji.value : this.emoji,
        type: type ?? this.type,
        sortOrder: sortOrder ?? this.sortOrder,
        archived: archived ?? this.archived,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        habitPeriod: habitPeriod.present ? habitPeriod.value : this.habitPeriod,
        habitValueOptions: habitValueOptions.present
            ? habitValueOptions.value
            : this.habitValueOptions,
        habitReminder:
            habitReminder.present ? habitReminder.value : this.habitReminder,
        habitAllowMultiple: habitAllowMultiple.present
            ? habitAllowMultiple.value
            : this.habitAllowMultiple,
        habitFreezeEnabled: habitFreezeEnabled.present
            ? habitFreezeEnabled.value
            : this.habitFreezeEnabled,
        habitFreezeEarnInterval: habitFreezeEarnInterval.present
            ? habitFreezeEarnInterval.value
            : this.habitFreezeEarnInterval,
        habitFreezeLimit: habitFreezeLimit.present
            ? habitFreezeLimit.value
            : this.habitFreezeLimit,
        habitFreezeRequireNote: habitFreezeRequireNote.present
            ? habitFreezeRequireNote.value
            : this.habitFreezeRequireNote,
        habitStreak: habitStreak.present ? habitStreak.value : this.habitStreak,
        habitLongestStreak: habitLongestStreak.present
            ? habitLongestStreak.value
            : this.habitLongestStreak,
        habitFreezesAvailable: habitFreezesAvailable.present
            ? habitFreezesAvailable.value
            : this.habitFreezesAvailable,
        goalUnit: goalUnit.present ? goalUnit.value : this.goalUnit,
        goalTargetAmount: goalTargetAmount.present
            ? goalTargetAmount.value
            : this.goalTargetAmount,
        goalStartDate:
            goalStartDate.present ? goalStartDate.value : this.goalStartDate,
        goalTargetDate:
            goalTargetDate.present ? goalTargetDate.value : this.goalTargetDate,
        goalStepSize:
            goalStepSize.present ? goalStepSize.value : this.goalStepSize,
        goalRunningTotal: goalRunningTotal.present
            ? goalRunningTotal.value
            : this.goalRunningTotal,
      );
  Tracker copyWithCompanion(TrackersCompanion data) {
    return Tracker(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
      type: data.type.present ? data.type.value : this.type,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      modifiedAt:
          data.modifiedAt.present ? data.modifiedAt.value : this.modifiedAt,
      habitPeriod:
          data.habitPeriod.present ? data.habitPeriod.value : this.habitPeriod,
      habitValueOptions: data.habitValueOptions.present
          ? data.habitValueOptions.value
          : this.habitValueOptions,
      habitReminder: data.habitReminder.present
          ? data.habitReminder.value
          : this.habitReminder,
      habitAllowMultiple: data.habitAllowMultiple.present
          ? data.habitAllowMultiple.value
          : this.habitAllowMultiple,
      habitFreezeEnabled: data.habitFreezeEnabled.present
          ? data.habitFreezeEnabled.value
          : this.habitFreezeEnabled,
      habitFreezeEarnInterval: data.habitFreezeEarnInterval.present
          ? data.habitFreezeEarnInterval.value
          : this.habitFreezeEarnInterval,
      habitFreezeLimit: data.habitFreezeLimit.present
          ? data.habitFreezeLimit.value
          : this.habitFreezeLimit,
      habitFreezeRequireNote: data.habitFreezeRequireNote.present
          ? data.habitFreezeRequireNote.value
          : this.habitFreezeRequireNote,
      habitStreak:
          data.habitStreak.present ? data.habitStreak.value : this.habitStreak,
      habitLongestStreak: data.habitLongestStreak.present
          ? data.habitLongestStreak.value
          : this.habitLongestStreak,
      habitFreezesAvailable: data.habitFreezesAvailable.present
          ? data.habitFreezesAvailable.value
          : this.habitFreezesAvailable,
      goalUnit: data.goalUnit.present ? data.goalUnit.value : this.goalUnit,
      goalTargetAmount: data.goalTargetAmount.present
          ? data.goalTargetAmount.value
          : this.goalTargetAmount,
      goalStartDate: data.goalStartDate.present
          ? data.goalStartDate.value
          : this.goalStartDate,
      goalTargetDate: data.goalTargetDate.present
          ? data.goalTargetDate.value
          : this.goalTargetDate,
      goalStepSize: data.goalStepSize.present
          ? data.goalStepSize.value
          : this.goalStepSize,
      goalRunningTotal: data.goalRunningTotal.present
          ? data.goalRunningTotal.value
          : this.goalRunningTotal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tracker(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('emoji: $emoji, ')
          ..write('type: $type, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('habitPeriod: $habitPeriod, ')
          ..write('habitValueOptions: $habitValueOptions, ')
          ..write('habitReminder: $habitReminder, ')
          ..write('habitAllowMultiple: $habitAllowMultiple, ')
          ..write('habitFreezeEnabled: $habitFreezeEnabled, ')
          ..write('habitFreezeEarnInterval: $habitFreezeEarnInterval, ')
          ..write('habitFreezeLimit: $habitFreezeLimit, ')
          ..write('habitFreezeRequireNote: $habitFreezeRequireNote, ')
          ..write('habitStreak: $habitStreak, ')
          ..write('habitLongestStreak: $habitLongestStreak, ')
          ..write('habitFreezesAvailable: $habitFreezesAvailable, ')
          ..write('goalUnit: $goalUnit, ')
          ..write('goalTargetAmount: $goalTargetAmount, ')
          ..write('goalStartDate: $goalStartDate, ')
          ..write('goalTargetDate: $goalTargetDate, ')
          ..write('goalStepSize: $goalStepSize, ')
          ..write('goalRunningTotal: $goalRunningTotal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        emoji,
        type,
        sortOrder,
        archived,
        createdAt,
        modifiedAt,
        habitPeriod,
        habitValueOptions,
        habitReminder,
        habitAllowMultiple,
        habitFreezeEnabled,
        habitFreezeEarnInterval,
        habitFreezeLimit,
        habitFreezeRequireNote,
        habitStreak,
        habitLongestStreak,
        habitFreezesAvailable,
        goalUnit,
        goalTargetAmount,
        goalStartDate,
        goalTargetDate,
        goalStepSize,
        goalRunningTotal
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tracker &&
          other.id == this.id &&
          other.name == this.name &&
          other.emoji == this.emoji &&
          other.type == this.type &&
          other.sortOrder == this.sortOrder &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.habitPeriod == this.habitPeriod &&
          other.habitValueOptions == this.habitValueOptions &&
          other.habitReminder == this.habitReminder &&
          other.habitAllowMultiple == this.habitAllowMultiple &&
          other.habitFreezeEnabled == this.habitFreezeEnabled &&
          other.habitFreezeEarnInterval == this.habitFreezeEarnInterval &&
          other.habitFreezeLimit == this.habitFreezeLimit &&
          other.habitFreezeRequireNote == this.habitFreezeRequireNote &&
          other.habitStreak == this.habitStreak &&
          other.habitLongestStreak == this.habitLongestStreak &&
          other.habitFreezesAvailable == this.habitFreezesAvailable &&
          other.goalUnit == this.goalUnit &&
          other.goalTargetAmount == this.goalTargetAmount &&
          other.goalStartDate == this.goalStartDate &&
          other.goalTargetDate == this.goalTargetDate &&
          other.goalStepSize == this.goalStepSize &&
          other.goalRunningTotal == this.goalRunningTotal);
}

class TrackersCompanion extends UpdateCompanion<Tracker> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> emoji;
  final Value<String> type;
  final Value<int> sortOrder;
  final Value<bool> archived;
  final Value<DateTime> createdAt;
  final Value<DateTime> modifiedAt;
  final Value<String?> habitPeriod;
  final Value<String?> habitValueOptions;
  final Value<String?> habitReminder;
  final Value<bool?> habitAllowMultiple;
  final Value<bool?> habitFreezeEnabled;
  final Value<int?> habitFreezeEarnInterval;
  final Value<int?> habitFreezeLimit;
  final Value<bool?> habitFreezeRequireNote;
  final Value<int?> habitStreak;
  final Value<int?> habitLongestStreak;
  final Value<int?> habitFreezesAvailable;
  final Value<String?> goalUnit;
  final Value<double?> goalTargetAmount;
  final Value<DateTime?> goalStartDate;
  final Value<DateTime?> goalTargetDate;
  final Value<double?> goalStepSize;
  final Value<double?> goalRunningTotal;
  const TrackersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.emoji = const Value.absent(),
    this.type = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.habitPeriod = const Value.absent(),
    this.habitValueOptions = const Value.absent(),
    this.habitReminder = const Value.absent(),
    this.habitAllowMultiple = const Value.absent(),
    this.habitFreezeEnabled = const Value.absent(),
    this.habitFreezeEarnInterval = const Value.absent(),
    this.habitFreezeLimit = const Value.absent(),
    this.habitFreezeRequireNote = const Value.absent(),
    this.habitStreak = const Value.absent(),
    this.habitLongestStreak = const Value.absent(),
    this.habitFreezesAvailable = const Value.absent(),
    this.goalUnit = const Value.absent(),
    this.goalTargetAmount = const Value.absent(),
    this.goalStartDate = const Value.absent(),
    this.goalTargetDate = const Value.absent(),
    this.goalStepSize = const Value.absent(),
    this.goalRunningTotal = const Value.absent(),
  });
  TrackersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.emoji = const Value.absent(),
    required String type,
    required int sortOrder,
    this.archived = const Value.absent(),
    required DateTime createdAt,
    required DateTime modifiedAt,
    this.habitPeriod = const Value.absent(),
    this.habitValueOptions = const Value.absent(),
    this.habitReminder = const Value.absent(),
    this.habitAllowMultiple = const Value.absent(),
    this.habitFreezeEnabled = const Value.absent(),
    this.habitFreezeEarnInterval = const Value.absent(),
    this.habitFreezeLimit = const Value.absent(),
    this.habitFreezeRequireNote = const Value.absent(),
    this.habitStreak = const Value.absent(),
    this.habitLongestStreak = const Value.absent(),
    this.habitFreezesAvailable = const Value.absent(),
    this.goalUnit = const Value.absent(),
    this.goalTargetAmount = const Value.absent(),
    this.goalStartDate = const Value.absent(),
    this.goalTargetDate = const Value.absent(),
    this.goalStepSize = const Value.absent(),
    this.goalRunningTotal = const Value.absent(),
  })  : name = Value(name),
        type = Value(type),
        sortOrder = Value(sortOrder),
        createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt);
  static Insertable<Tracker> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? emoji,
    Expression<String>? type,
    Expression<int>? sortOrder,
    Expression<bool>? archived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? modifiedAt,
    Expression<String>? habitPeriod,
    Expression<String>? habitValueOptions,
    Expression<String>? habitReminder,
    Expression<bool>? habitAllowMultiple,
    Expression<bool>? habitFreezeEnabled,
    Expression<int>? habitFreezeEarnInterval,
    Expression<int>? habitFreezeLimit,
    Expression<bool>? habitFreezeRequireNote,
    Expression<int>? habitStreak,
    Expression<int>? habitLongestStreak,
    Expression<int>? habitFreezesAvailable,
    Expression<String>? goalUnit,
    Expression<double>? goalTargetAmount,
    Expression<DateTime>? goalStartDate,
    Expression<DateTime>? goalTargetDate,
    Expression<double>? goalStepSize,
    Expression<double>? goalRunningTotal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (emoji != null) 'emoji': emoji,
      if (type != null) 'type': type,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (habitPeriod != null) 'habit_period': habitPeriod,
      if (habitValueOptions != null) 'habit_value_options': habitValueOptions,
      if (habitReminder != null) 'habit_reminder': habitReminder,
      if (habitAllowMultiple != null)
        'habit_allow_multiple': habitAllowMultiple,
      if (habitFreezeEnabled != null)
        'habit_freeze_enabled': habitFreezeEnabled,
      if (habitFreezeEarnInterval != null)
        'habit_freeze_earn_interval': habitFreezeEarnInterval,
      if (habitFreezeLimit != null) 'habit_freeze_limit': habitFreezeLimit,
      if (habitFreezeRequireNote != null)
        'habit_freeze_require_note': habitFreezeRequireNote,
      if (habitStreak != null) 'habit_streak': habitStreak,
      if (habitLongestStreak != null)
        'habit_longest_streak': habitLongestStreak,
      if (habitFreezesAvailable != null)
        'habit_freezes_available': habitFreezesAvailable,
      if (goalUnit != null) 'goal_unit': goalUnit,
      if (goalTargetAmount != null) 'goal_target_amount': goalTargetAmount,
      if (goalStartDate != null) 'goal_start_date': goalStartDate,
      if (goalTargetDate != null) 'goal_target_date': goalTargetDate,
      if (goalStepSize != null) 'goal_step_size': goalStepSize,
      if (goalRunningTotal != null) 'goal_running_total': goalRunningTotal,
    });
  }

  TrackersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? emoji,
      Value<String>? type,
      Value<int>? sortOrder,
      Value<bool>? archived,
      Value<DateTime>? createdAt,
      Value<DateTime>? modifiedAt,
      Value<String?>? habitPeriod,
      Value<String?>? habitValueOptions,
      Value<String?>? habitReminder,
      Value<bool?>? habitAllowMultiple,
      Value<bool?>? habitFreezeEnabled,
      Value<int?>? habitFreezeEarnInterval,
      Value<int?>? habitFreezeLimit,
      Value<bool?>? habitFreezeRequireNote,
      Value<int?>? habitStreak,
      Value<int?>? habitLongestStreak,
      Value<int?>? habitFreezesAvailable,
      Value<String?>? goalUnit,
      Value<double?>? goalTargetAmount,
      Value<DateTime?>? goalStartDate,
      Value<DateTime?>? goalTargetDate,
      Value<double?>? goalStepSize,
      Value<double?>? goalRunningTotal}) {
    return TrackersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      type: type ?? this.type,
      sortOrder: sortOrder ?? this.sortOrder,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      habitPeriod: habitPeriod ?? this.habitPeriod,
      habitValueOptions: habitValueOptions ?? this.habitValueOptions,
      habitReminder: habitReminder ?? this.habitReminder,
      habitAllowMultiple: habitAllowMultiple ?? this.habitAllowMultiple,
      habitFreezeEnabled: habitFreezeEnabled ?? this.habitFreezeEnabled,
      habitFreezeEarnInterval:
          habitFreezeEarnInterval ?? this.habitFreezeEarnInterval,
      habitFreezeLimit: habitFreezeLimit ?? this.habitFreezeLimit,
      habitFreezeRequireNote:
          habitFreezeRequireNote ?? this.habitFreezeRequireNote,
      habitStreak: habitStreak ?? this.habitStreak,
      habitLongestStreak: habitLongestStreak ?? this.habitLongestStreak,
      habitFreezesAvailable:
          habitFreezesAvailable ?? this.habitFreezesAvailable,
      goalUnit: goalUnit ?? this.goalUnit,
      goalTargetAmount: goalTargetAmount ?? this.goalTargetAmount,
      goalStartDate: goalStartDate ?? this.goalStartDate,
      goalTargetDate: goalTargetDate ?? this.goalTargetDate,
      goalStepSize: goalStepSize ?? this.goalStepSize,
      goalRunningTotal: goalRunningTotal ?? this.goalRunningTotal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (habitPeriod.present) {
      map['habit_period'] = Variable<String>(habitPeriod.value);
    }
    if (habitValueOptions.present) {
      map['habit_value_options'] = Variable<String>(habitValueOptions.value);
    }
    if (habitReminder.present) {
      map['habit_reminder'] = Variable<String>(habitReminder.value);
    }
    if (habitAllowMultiple.present) {
      map['habit_allow_multiple'] = Variable<bool>(habitAllowMultiple.value);
    }
    if (habitFreezeEnabled.present) {
      map['habit_freeze_enabled'] = Variable<bool>(habitFreezeEnabled.value);
    }
    if (habitFreezeEarnInterval.present) {
      map['habit_freeze_earn_interval'] =
          Variable<int>(habitFreezeEarnInterval.value);
    }
    if (habitFreezeLimit.present) {
      map['habit_freeze_limit'] = Variable<int>(habitFreezeLimit.value);
    }
    if (habitFreezeRequireNote.present) {
      map['habit_freeze_require_note'] =
          Variable<bool>(habitFreezeRequireNote.value);
    }
    if (habitStreak.present) {
      map['habit_streak'] = Variable<int>(habitStreak.value);
    }
    if (habitLongestStreak.present) {
      map['habit_longest_streak'] = Variable<int>(habitLongestStreak.value);
    }
    if (habitFreezesAvailable.present) {
      map['habit_freezes_available'] =
          Variable<int>(habitFreezesAvailable.value);
    }
    if (goalUnit.present) {
      map['goal_unit'] = Variable<String>(goalUnit.value);
    }
    if (goalTargetAmount.present) {
      map['goal_target_amount'] = Variable<double>(goalTargetAmount.value);
    }
    if (goalStartDate.present) {
      map['goal_start_date'] = Variable<DateTime>(goalStartDate.value);
    }
    if (goalTargetDate.present) {
      map['goal_target_date'] = Variable<DateTime>(goalTargetDate.value);
    }
    if (goalStepSize.present) {
      map['goal_step_size'] = Variable<double>(goalStepSize.value);
    }
    if (goalRunningTotal.present) {
      map['goal_running_total'] = Variable<double>(goalRunningTotal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('emoji: $emoji, ')
          ..write('type: $type, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('habitPeriod: $habitPeriod, ')
          ..write('habitValueOptions: $habitValueOptions, ')
          ..write('habitReminder: $habitReminder, ')
          ..write('habitAllowMultiple: $habitAllowMultiple, ')
          ..write('habitFreezeEnabled: $habitFreezeEnabled, ')
          ..write('habitFreezeEarnInterval: $habitFreezeEarnInterval, ')
          ..write('habitFreezeLimit: $habitFreezeLimit, ')
          ..write('habitFreezeRequireNote: $habitFreezeRequireNote, ')
          ..write('habitStreak: $habitStreak, ')
          ..write('habitLongestStreak: $habitLongestStreak, ')
          ..write('habitFreezesAvailable: $habitFreezesAvailable, ')
          ..write('goalUnit: $goalUnit, ')
          ..write('goalTargetAmount: $goalTargetAmount, ')
          ..write('goalStartDate: $goalStartDate, ')
          ..write('goalTargetDate: $goalTargetDate, ')
          ..write('goalStepSize: $goalStepSize, ')
          ..write('goalRunningTotal: $goalRunningTotal')
          ..write(')'))
        .toString();
  }
}

class $LogsTable extends Logs with TableInfo<$LogsTable, Log> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _trackerIdMeta =
      const VerificationMeta('trackerId');
  @override
  late final GeneratedColumn<int> trackerId = GeneratedColumn<int>(
      'tracker_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES trackers (id)'));
  static const VerificationMeta _logDateMeta =
      const VerificationMeta('logDate');
  @override
  late final GeneratedColumn<String> logDate = GeneratedColumn<String>(
      'log_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _modifiedAtMeta =
      const VerificationMeta('modifiedAt');
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
      'modified_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isFreezeMeta =
      const VerificationMeta('isFreeze');
  @override
  late final GeneratedColumn<bool> isFreeze = GeneratedColumn<bool>(
      'is_freeze', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_freeze" IN (0, 1))'));
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, trackerId, logDate, createdAt, modifiedAt, value, isFreeze, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'logs';
  @override
  VerificationContext validateIntegrity(Insertable<Log> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tracker_id')) {
      context.handle(_trackerIdMeta,
          trackerId.isAcceptableOrUnknown(data['tracker_id']!, _trackerIdMeta));
    } else if (isInserting) {
      context.missing(_trackerIdMeta);
    }
    if (data.containsKey('log_date')) {
      context.handle(_logDateMeta,
          logDate.isAcceptableOrUnknown(data['log_date']!, _logDateMeta));
    } else if (isInserting) {
      context.missing(_logDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at']!, _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    if (data.containsKey('is_freeze')) {
      context.handle(_isFreezeMeta,
          isFreeze.isAcceptableOrUnknown(data['is_freeze']!, _isFreezeMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Log map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Log(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      trackerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tracker_id'])!,
      logDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}log_date'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      modifiedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}modified_at'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value']),
      isFreeze: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_freeze']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $LogsTable createAlias(String alias) {
    return $LogsTable(attachedDatabase, alias);
  }
}

class Log extends DataClass implements Insertable<Log> {
  final int id;
  final int trackerId;
  final String logDate;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final double? value;
  final bool? isFreeze;
  final String? note;
  const Log(
      {required this.id,
      required this.trackerId,
      required this.logDate,
      required this.createdAt,
      required this.modifiedAt,
      this.value,
      this.isFreeze,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tracker_id'] = Variable<int>(trackerId);
    map['log_date'] = Variable<String>(logDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<double>(value);
    }
    if (!nullToAbsent || isFreeze != null) {
      map['is_freeze'] = Variable<bool>(isFreeze);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  LogsCompanion toCompanion(bool nullToAbsent) {
    return LogsCompanion(
      id: Value(id),
      trackerId: Value(trackerId),
      logDate: Value(logDate),
      createdAt: Value(createdAt),
      modifiedAt: Value(modifiedAt),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      isFreeze: isFreeze == null && nullToAbsent
          ? const Value.absent()
          : Value(isFreeze),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Log.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Log(
      id: serializer.fromJson<int>(json['id']),
      trackerId: serializer.fromJson<int>(json['trackerId']),
      logDate: serializer.fromJson<String>(json['logDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
      value: serializer.fromJson<double?>(json['value']),
      isFreeze: serializer.fromJson<bool?>(json['isFreeze']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'trackerId': serializer.toJson<int>(trackerId),
      'logDate': serializer.toJson<String>(logDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
      'value': serializer.toJson<double?>(value),
      'isFreeze': serializer.toJson<bool?>(isFreeze),
      'note': serializer.toJson<String?>(note),
    };
  }

  Log copyWith(
          {int? id,
          int? trackerId,
          String? logDate,
          DateTime? createdAt,
          DateTime? modifiedAt,
          Value<double?> value = const Value.absent(),
          Value<bool?> isFreeze = const Value.absent(),
          Value<String?> note = const Value.absent()}) =>
      Log(
        id: id ?? this.id,
        trackerId: trackerId ?? this.trackerId,
        logDate: logDate ?? this.logDate,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        value: value.present ? value.value : this.value,
        isFreeze: isFreeze.present ? isFreeze.value : this.isFreeze,
        note: note.present ? note.value : this.note,
      );
  Log copyWithCompanion(LogsCompanion data) {
    return Log(
      id: data.id.present ? data.id.value : this.id,
      trackerId: data.trackerId.present ? data.trackerId.value : this.trackerId,
      logDate: data.logDate.present ? data.logDate.value : this.logDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      modifiedAt:
          data.modifiedAt.present ? data.modifiedAt.value : this.modifiedAt,
      value: data.value.present ? data.value.value : this.value,
      isFreeze: data.isFreeze.present ? data.isFreeze.value : this.isFreeze,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Log(')
          ..write('id: $id, ')
          ..write('trackerId: $trackerId, ')
          ..write('logDate: $logDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('value: $value, ')
          ..write('isFreeze: $isFreeze, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, trackerId, logDate, createdAt, modifiedAt, value, isFreeze, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Log &&
          other.id == this.id &&
          other.trackerId == this.trackerId &&
          other.logDate == this.logDate &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.value == this.value &&
          other.isFreeze == this.isFreeze &&
          other.note == this.note);
}

class LogsCompanion extends UpdateCompanion<Log> {
  final Value<int> id;
  final Value<int> trackerId;
  final Value<String> logDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> modifiedAt;
  final Value<double?> value;
  final Value<bool?> isFreeze;
  final Value<String?> note;
  const LogsCompanion({
    this.id = const Value.absent(),
    this.trackerId = const Value.absent(),
    this.logDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.value = const Value.absent(),
    this.isFreeze = const Value.absent(),
    this.note = const Value.absent(),
  });
  LogsCompanion.insert({
    this.id = const Value.absent(),
    required int trackerId,
    required String logDate,
    required DateTime createdAt,
    required DateTime modifiedAt,
    this.value = const Value.absent(),
    this.isFreeze = const Value.absent(),
    this.note = const Value.absent(),
  })  : trackerId = Value(trackerId),
        logDate = Value(logDate),
        createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt);
  static Insertable<Log> custom({
    Expression<int>? id,
    Expression<int>? trackerId,
    Expression<String>? logDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? modifiedAt,
    Expression<double>? value,
    Expression<bool>? isFreeze,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trackerId != null) 'tracker_id': trackerId,
      if (logDate != null) 'log_date': logDate,
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (value != null) 'value': value,
      if (isFreeze != null) 'is_freeze': isFreeze,
      if (note != null) 'note': note,
    });
  }

  LogsCompanion copyWith(
      {Value<int>? id,
      Value<int>? trackerId,
      Value<String>? logDate,
      Value<DateTime>? createdAt,
      Value<DateTime>? modifiedAt,
      Value<double?>? value,
      Value<bool?>? isFreeze,
      Value<String?>? note}) {
    return LogsCompanion(
      id: id ?? this.id,
      trackerId: trackerId ?? this.trackerId,
      logDate: logDate ?? this.logDate,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      value: value ?? this.value,
      isFreeze: isFreeze ?? this.isFreeze,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (trackerId.present) {
      map['tracker_id'] = Variable<int>(trackerId.value);
    }
    if (logDate.present) {
      map['log_date'] = Variable<String>(logDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (isFreeze.present) {
      map['is_freeze'] = Variable<bool>(isFreeze.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogsCompanion(')
          ..write('id: $id, ')
          ..write('trackerId: $trackerId, ')
          ..write('logDate: $logDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('value: $value, ')
          ..write('isFreeze: $isFreeze, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TrackersTable trackers = $TrackersTable(this);
  late final $LogsTable logs = $LogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [trackers, logs];
}

typedef $$TrackersTableCreateCompanionBuilder = TrackersCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> emoji,
  required String type,
  required int sortOrder,
  Value<bool> archived,
  required DateTime createdAt,
  required DateTime modifiedAt,
  Value<String?> habitPeriod,
  Value<String?> habitValueOptions,
  Value<String?> habitReminder,
  Value<bool?> habitAllowMultiple,
  Value<bool?> habitFreezeEnabled,
  Value<int?> habitFreezeEarnInterval,
  Value<int?> habitFreezeLimit,
  Value<bool?> habitFreezeRequireNote,
  Value<int?> habitStreak,
  Value<int?> habitLongestStreak,
  Value<int?> habitFreezesAvailable,
  Value<String?> goalUnit,
  Value<double?> goalTargetAmount,
  Value<DateTime?> goalStartDate,
  Value<DateTime?> goalTargetDate,
  Value<double?> goalStepSize,
  Value<double?> goalRunningTotal,
});
typedef $$TrackersTableUpdateCompanionBuilder = TrackersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> emoji,
  Value<String> type,
  Value<int> sortOrder,
  Value<bool> archived,
  Value<DateTime> createdAt,
  Value<DateTime> modifiedAt,
  Value<String?> habitPeriod,
  Value<String?> habitValueOptions,
  Value<String?> habitReminder,
  Value<bool?> habitAllowMultiple,
  Value<bool?> habitFreezeEnabled,
  Value<int?> habitFreezeEarnInterval,
  Value<int?> habitFreezeLimit,
  Value<bool?> habitFreezeRequireNote,
  Value<int?> habitStreak,
  Value<int?> habitLongestStreak,
  Value<int?> habitFreezesAvailable,
  Value<String?> goalUnit,
  Value<double?> goalTargetAmount,
  Value<DateTime?> goalStartDate,
  Value<DateTime?> goalTargetDate,
  Value<double?> goalStepSize,
  Value<double?> goalRunningTotal,
});

final class $$TrackersTableReferences
    extends BaseReferences<_$AppDatabase, $TrackersTable, Tracker> {
  $$TrackersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LogsTable, List<Log>> _logsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.logs,
          aliasName: $_aliasNameGenerator(db.trackers.id, db.logs.trackerId));

  $$LogsTableProcessedTableManager get logsRefs {
    final manager = $$LogsTableTableManager($_db, $_db.logs)
        .filter((f) => f.trackerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_logsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TrackersTableFilterComposer
    extends Composer<_$AppDatabase, $TrackersTable> {
  $$TrackersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get emoji => $composableBuilder(
      column: $table.emoji, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get archived => $composableBuilder(
      column: $table.archived, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get habitPeriod => $composableBuilder(
      column: $table.habitPeriod, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get habitValueOptions => $composableBuilder(
      column: $table.habitValueOptions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get habitReminder => $composableBuilder(
      column: $table.habitReminder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get habitAllowMultiple => $composableBuilder(
      column: $table.habitAllowMultiple,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get habitFreezeEnabled => $composableBuilder(
      column: $table.habitFreezeEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get habitFreezeEarnInterval => $composableBuilder(
      column: $table.habitFreezeEarnInterval,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get habitFreezeLimit => $composableBuilder(
      column: $table.habitFreezeLimit,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get habitFreezeRequireNote => $composableBuilder(
      column: $table.habitFreezeRequireNote,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get habitStreak => $composableBuilder(
      column: $table.habitStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get habitLongestStreak => $composableBuilder(
      column: $table.habitLongestStreak,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get habitFreezesAvailable => $composableBuilder(
      column: $table.habitFreezesAvailable,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get goalUnit => $composableBuilder(
      column: $table.goalUnit, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get goalTargetAmount => $composableBuilder(
      column: $table.goalTargetAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get goalStartDate => $composableBuilder(
      column: $table.goalStartDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get goalTargetDate => $composableBuilder(
      column: $table.goalTargetDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get goalStepSize => $composableBuilder(
      column: $table.goalStepSize, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get goalRunningTotal => $composableBuilder(
      column: $table.goalRunningTotal,
      builder: (column) => ColumnFilters(column));

  Expression<bool> logsRefs(
      Expression<bool> Function($$LogsTableFilterComposer f) f) {
    final $$LogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.logs,
        getReferencedColumn: (t) => t.trackerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LogsTableFilterComposer(
              $db: $db,
              $table: $db.logs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TrackersTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackersTable> {
  $$TrackersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get emoji => $composableBuilder(
      column: $table.emoji, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get archived => $composableBuilder(
      column: $table.archived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get habitPeriod => $composableBuilder(
      column: $table.habitPeriod, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get habitValueOptions => $composableBuilder(
      column: $table.habitValueOptions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get habitReminder => $composableBuilder(
      column: $table.habitReminder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get habitAllowMultiple => $composableBuilder(
      column: $table.habitAllowMultiple,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get habitFreezeEnabled => $composableBuilder(
      column: $table.habitFreezeEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get habitFreezeEarnInterval => $composableBuilder(
      column: $table.habitFreezeEarnInterval,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get habitFreezeLimit => $composableBuilder(
      column: $table.habitFreezeLimit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get habitFreezeRequireNote => $composableBuilder(
      column: $table.habitFreezeRequireNote,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get habitStreak => $composableBuilder(
      column: $table.habitStreak, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get habitLongestStreak => $composableBuilder(
      column: $table.habitLongestStreak,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get habitFreezesAvailable => $composableBuilder(
      column: $table.habitFreezesAvailable,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get goalUnit => $composableBuilder(
      column: $table.goalUnit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get goalTargetAmount => $composableBuilder(
      column: $table.goalTargetAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get goalStartDate => $composableBuilder(
      column: $table.goalStartDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get goalTargetDate => $composableBuilder(
      column: $table.goalTargetDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get goalStepSize => $composableBuilder(
      column: $table.goalStepSize,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get goalRunningTotal => $composableBuilder(
      column: $table.goalRunningTotal,
      builder: (column) => ColumnOrderings(column));
}

class $$TrackersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackersTable> {
  $$TrackersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => column);

  GeneratedColumn<String> get habitPeriod => $composableBuilder(
      column: $table.habitPeriod, builder: (column) => column);

  GeneratedColumn<String> get habitValueOptions => $composableBuilder(
      column: $table.habitValueOptions, builder: (column) => column);

  GeneratedColumn<String> get habitReminder => $composableBuilder(
      column: $table.habitReminder, builder: (column) => column);

  GeneratedColumn<bool> get habitAllowMultiple => $composableBuilder(
      column: $table.habitAllowMultiple, builder: (column) => column);

  GeneratedColumn<bool> get habitFreezeEnabled => $composableBuilder(
      column: $table.habitFreezeEnabled, builder: (column) => column);

  GeneratedColumn<int> get habitFreezeEarnInterval => $composableBuilder(
      column: $table.habitFreezeEarnInterval, builder: (column) => column);

  GeneratedColumn<int> get habitFreezeLimit => $composableBuilder(
      column: $table.habitFreezeLimit, builder: (column) => column);

  GeneratedColumn<bool> get habitFreezeRequireNote => $composableBuilder(
      column: $table.habitFreezeRequireNote, builder: (column) => column);

  GeneratedColumn<int> get habitStreak => $composableBuilder(
      column: $table.habitStreak, builder: (column) => column);

  GeneratedColumn<int> get habitLongestStreak => $composableBuilder(
      column: $table.habitLongestStreak, builder: (column) => column);

  GeneratedColumn<int> get habitFreezesAvailable => $composableBuilder(
      column: $table.habitFreezesAvailable, builder: (column) => column);

  GeneratedColumn<String> get goalUnit =>
      $composableBuilder(column: $table.goalUnit, builder: (column) => column);

  GeneratedColumn<double> get goalTargetAmount => $composableBuilder(
      column: $table.goalTargetAmount, builder: (column) => column);

  GeneratedColumn<DateTime> get goalStartDate => $composableBuilder(
      column: $table.goalStartDate, builder: (column) => column);

  GeneratedColumn<DateTime> get goalTargetDate => $composableBuilder(
      column: $table.goalTargetDate, builder: (column) => column);

  GeneratedColumn<double> get goalStepSize => $composableBuilder(
      column: $table.goalStepSize, builder: (column) => column);

  GeneratedColumn<double> get goalRunningTotal => $composableBuilder(
      column: $table.goalRunningTotal, builder: (column) => column);

  Expression<T> logsRefs<T extends Object>(
      Expression<T> Function($$LogsTableAnnotationComposer a) f) {
    final $$LogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.logs,
        getReferencedColumn: (t) => t.trackerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LogsTableAnnotationComposer(
              $db: $db,
              $table: $db.logs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TrackersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TrackersTable,
    Tracker,
    $$TrackersTableFilterComposer,
    $$TrackersTableOrderingComposer,
    $$TrackersTableAnnotationComposer,
    $$TrackersTableCreateCompanionBuilder,
    $$TrackersTableUpdateCompanionBuilder,
    (Tracker, $$TrackersTableReferences),
    Tracker,
    PrefetchHooks Function({bool logsRefs})> {
  $$TrackersTableTableManager(_$AppDatabase db, $TrackersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> emoji = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> archived = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> modifiedAt = const Value.absent(),
            Value<String?> habitPeriod = const Value.absent(),
            Value<String?> habitValueOptions = const Value.absent(),
            Value<String?> habitReminder = const Value.absent(),
            Value<bool?> habitAllowMultiple = const Value.absent(),
            Value<bool?> habitFreezeEnabled = const Value.absent(),
            Value<int?> habitFreezeEarnInterval = const Value.absent(),
            Value<int?> habitFreezeLimit = const Value.absent(),
            Value<bool?> habitFreezeRequireNote = const Value.absent(),
            Value<int?> habitStreak = const Value.absent(),
            Value<int?> habitLongestStreak = const Value.absent(),
            Value<int?> habitFreezesAvailable = const Value.absent(),
            Value<String?> goalUnit = const Value.absent(),
            Value<double?> goalTargetAmount = const Value.absent(),
            Value<DateTime?> goalStartDate = const Value.absent(),
            Value<DateTime?> goalTargetDate = const Value.absent(),
            Value<double?> goalStepSize = const Value.absent(),
            Value<double?> goalRunningTotal = const Value.absent(),
          }) =>
              TrackersCompanion(
            id: id,
            name: name,
            emoji: emoji,
            type: type,
            sortOrder: sortOrder,
            archived: archived,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            habitPeriod: habitPeriod,
            habitValueOptions: habitValueOptions,
            habitReminder: habitReminder,
            habitAllowMultiple: habitAllowMultiple,
            habitFreezeEnabled: habitFreezeEnabled,
            habitFreezeEarnInterval: habitFreezeEarnInterval,
            habitFreezeLimit: habitFreezeLimit,
            habitFreezeRequireNote: habitFreezeRequireNote,
            habitStreak: habitStreak,
            habitLongestStreak: habitLongestStreak,
            habitFreezesAvailable: habitFreezesAvailable,
            goalUnit: goalUnit,
            goalTargetAmount: goalTargetAmount,
            goalStartDate: goalStartDate,
            goalTargetDate: goalTargetDate,
            goalStepSize: goalStepSize,
            goalRunningTotal: goalRunningTotal,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> emoji = const Value.absent(),
            required String type,
            required int sortOrder,
            Value<bool> archived = const Value.absent(),
            required DateTime createdAt,
            required DateTime modifiedAt,
            Value<String?> habitPeriod = const Value.absent(),
            Value<String?> habitValueOptions = const Value.absent(),
            Value<String?> habitReminder = const Value.absent(),
            Value<bool?> habitAllowMultiple = const Value.absent(),
            Value<bool?> habitFreezeEnabled = const Value.absent(),
            Value<int?> habitFreezeEarnInterval = const Value.absent(),
            Value<int?> habitFreezeLimit = const Value.absent(),
            Value<bool?> habitFreezeRequireNote = const Value.absent(),
            Value<int?> habitStreak = const Value.absent(),
            Value<int?> habitLongestStreak = const Value.absent(),
            Value<int?> habitFreezesAvailable = const Value.absent(),
            Value<String?> goalUnit = const Value.absent(),
            Value<double?> goalTargetAmount = const Value.absent(),
            Value<DateTime?> goalStartDate = const Value.absent(),
            Value<DateTime?> goalTargetDate = const Value.absent(),
            Value<double?> goalStepSize = const Value.absent(),
            Value<double?> goalRunningTotal = const Value.absent(),
          }) =>
              TrackersCompanion.insert(
            id: id,
            name: name,
            emoji: emoji,
            type: type,
            sortOrder: sortOrder,
            archived: archived,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            habitPeriod: habitPeriod,
            habitValueOptions: habitValueOptions,
            habitReminder: habitReminder,
            habitAllowMultiple: habitAllowMultiple,
            habitFreezeEnabled: habitFreezeEnabled,
            habitFreezeEarnInterval: habitFreezeEarnInterval,
            habitFreezeLimit: habitFreezeLimit,
            habitFreezeRequireNote: habitFreezeRequireNote,
            habitStreak: habitStreak,
            habitLongestStreak: habitLongestStreak,
            habitFreezesAvailable: habitFreezesAvailable,
            goalUnit: goalUnit,
            goalTargetAmount: goalTargetAmount,
            goalStartDate: goalStartDate,
            goalTargetDate: goalTargetDate,
            goalStepSize: goalStepSize,
            goalRunningTotal: goalRunningTotal,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TrackersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({logsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (logsRefs) db.logs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (logsRefs)
                    await $_getPrefetchedData<Tracker, $TrackersTable, Log>(
                        currentTable: table,
                        referencedTable:
                            $$TrackersTableReferences._logsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TrackersTableReferences(db, table, p0).logsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.trackerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TrackersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TrackersTable,
    Tracker,
    $$TrackersTableFilterComposer,
    $$TrackersTableOrderingComposer,
    $$TrackersTableAnnotationComposer,
    $$TrackersTableCreateCompanionBuilder,
    $$TrackersTableUpdateCompanionBuilder,
    (Tracker, $$TrackersTableReferences),
    Tracker,
    PrefetchHooks Function({bool logsRefs})>;
typedef $$LogsTableCreateCompanionBuilder = LogsCompanion Function({
  Value<int> id,
  required int trackerId,
  required String logDate,
  required DateTime createdAt,
  required DateTime modifiedAt,
  Value<double?> value,
  Value<bool?> isFreeze,
  Value<String?> note,
});
typedef $$LogsTableUpdateCompanionBuilder = LogsCompanion Function({
  Value<int> id,
  Value<int> trackerId,
  Value<String> logDate,
  Value<DateTime> createdAt,
  Value<DateTime> modifiedAt,
  Value<double?> value,
  Value<bool?> isFreeze,
  Value<String?> note,
});

final class $$LogsTableReferences
    extends BaseReferences<_$AppDatabase, $LogsTable, Log> {
  $$LogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TrackersTable _trackerIdTable(_$AppDatabase db) => db.trackers
      .createAlias($_aliasNameGenerator(db.logs.trackerId, db.trackers.id));

  $$TrackersTableProcessedTableManager get trackerId {
    final $_column = $_itemColumn<int>('tracker_id')!;

    final manager = $$TrackersTableTableManager($_db, $_db.trackers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trackerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LogsTableFilterComposer extends Composer<_$AppDatabase, $LogsTable> {
  $$LogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get logDate => $composableBuilder(
      column: $table.logDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFreeze => $composableBuilder(
      column: $table.isFreeze, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  $$TrackersTableFilterComposer get trackerId {
    final $$TrackersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trackerId,
        referencedTable: $db.trackers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrackersTableFilterComposer(
              $db: $db,
              $table: $db.trackers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LogsTableOrderingComposer extends Composer<_$AppDatabase, $LogsTable> {
  $$LogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get logDate => $composableBuilder(
      column: $table.logDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFreeze => $composableBuilder(
      column: $table.isFreeze, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  $$TrackersTableOrderingComposer get trackerId {
    final $$TrackersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trackerId,
        referencedTable: $db.trackers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrackersTableOrderingComposer(
              $db: $db,
              $table: $db.trackers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogsTable> {
  $$LogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get logDate =>
      $composableBuilder(column: $table.logDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<bool> get isFreeze =>
      $composableBuilder(column: $table.isFreeze, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$TrackersTableAnnotationComposer get trackerId {
    final $$TrackersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.trackerId,
        referencedTable: $db.trackers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrackersTableAnnotationComposer(
              $db: $db,
              $table: $db.trackers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LogsTable,
    Log,
    $$LogsTableFilterComposer,
    $$LogsTableOrderingComposer,
    $$LogsTableAnnotationComposer,
    $$LogsTableCreateCompanionBuilder,
    $$LogsTableUpdateCompanionBuilder,
    (Log, $$LogsTableReferences),
    Log,
    PrefetchHooks Function({bool trackerId})> {
  $$LogsTableTableManager(_$AppDatabase db, $LogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> trackerId = const Value.absent(),
            Value<String> logDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> modifiedAt = const Value.absent(),
            Value<double?> value = const Value.absent(),
            Value<bool?> isFreeze = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              LogsCompanion(
            id: id,
            trackerId: trackerId,
            logDate: logDate,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            value: value,
            isFreeze: isFreeze,
            note: note,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int trackerId,
            required String logDate,
            required DateTime createdAt,
            required DateTime modifiedAt,
            Value<double?> value = const Value.absent(),
            Value<bool?> isFreeze = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              LogsCompanion.insert(
            id: id,
            trackerId: trackerId,
            logDate: logDate,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            value: value,
            isFreeze: isFreeze,
            note: note,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$LogsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({trackerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (trackerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.trackerId,
                    referencedTable: $$LogsTableReferences._trackerIdTable(db),
                    referencedColumn:
                        $$LogsTableReferences._trackerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LogsTable,
    Log,
    $$LogsTableFilterComposer,
    $$LogsTableOrderingComposer,
    $$LogsTableAnnotationComposer,
    $$LogsTableCreateCompanionBuilder,
    $$LogsTableUpdateCompanionBuilder,
    (Log, $$LogsTableReferences),
    Log,
    PrefetchHooks Function({bool trackerId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TrackersTableTableManager get trackers =>
      $$TrackersTableTableManager(_db, _db.trackers);
  $$LogsTableTableManager get logs => $$LogsTableTableManager(_db, _db.logs);
}
