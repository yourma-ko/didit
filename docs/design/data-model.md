# Data Model

This data model is for the phone app's sqlite database. The UI might be a bit
different but we should try and keep them in sync.

## Tracker

A tracker is one thing you want to follow over time. There are two kinds:

- **Habit** - something you do repeatedly on a schedule, where consistency is
  the goal. Each log is a discrete value like "did it" or a rating (1-5 for
  mood).
- **Goal** - something you accumulate. Toward a target or just to make the
  number bigger. Each log adds to a running total (e.g. meters swum, pages read,
  jobs applied, books finished).

### Tracker entry

Every tracker has:

- **Name** - a short label chosen by the user (e.g. "Morning run", "Mood")
- **Emoji** - optional visual marker stored separately from the name so the UI
  can place it beside, above, or inside a tracker card without changing the
  tracker's label
- **Type** - Habit or Goal
- **SortOrder** - integer position used for reordering on the home screen
- **Archived** - hide the tracker without deleting its history
- **Created at** - timestamp of when the tracker was created
- **Modified at** - timestamp of when the tracker was last modified

Habit-only fields:

- **HabitPeriod** - how often the habit is expected to be logged (daily, weekly,
  monthly)
- **HabitValueOptions** - ordered list of value labels; empty for binary habits
  (see below)
- **HabitAllowMultiple** - whether multiple logs per period are allowed
- **HabitReminder** - optional JSON: enabled, hour, minute, ISO weekdays 1–7.
  A device-local wall-clock reminder, independent of the logging period. Null
  means disabled. Schema 5 adds it without changing existing logs or streaks.
- **HabitFreezeEnabled** - whether streak freezes are turned on
- **HabitFreezeEarnInterval** - earn a freeze once every N days
- **HabitFreezeLimit** - maximum freezes that can be accumulated
- **HabitFreezeRequireNote** - whether a note is required when using a freeze

Goal-only fields:

- **GoalUnit** - what the number measures (e.g. meters, books); optional
- **GoalTargetAmount** - the number to reach; optional
- **GoalStartDate** - when the goal begins; used together with GoalTargetDate
  and GoalTargetAmount to compute expected linear progress ("the ghost");
  optional
- **GoalTargetDate** - deadline to reach the target; optional
- **GoalStepSize** - the ui should make it easy to add fixed amount per log;
  optional, free-form entry if absent

Denormalized derived fields (stored for fast display, recomputed from log
entries):

- **HabitStreak** - number of consecutive periods with a completed log
- **HabitLongestStreak** - all-time best streak
- **HabitFreezesAvailable** - how many freezes the user currently holds
- **GoalRunningTotal** - sum of all logged values so far

### Habit

#### Value options

`HabitValueOptions` can be empty or non-empty:

- **Empty** - binary habit. The log entry either exists (done) or doesn't
  (missed). No value is stored. The UX shows a single tap to mark it done.
- **Non-empty** - each log stores the position of the chosen label (0, 1, 2, …).
  Examples: 1 / 2 / 3 / 4 / 5 for mood; or Run / Cycle / Swim for a cardio habit
  where you want to track _what_ you did, not just _that_ you did it.

Absence of a log entry means the habit was not completed that period - there is
no "skipped" value. This keeps charting simple: a calendar heatmap shows logged
days (color-coded by value for rated habits), gaps are missed days.

Streak freeze is not a value option - it is a separate field on the log entry
(see below), so toggling freezes on or off never changes the meaning of existing
logs.

#### Schedule

How often the habit is expected to be logged:

- Once a day
- Once a week
- Once a month

Toggle: **allow multiple logs per period** - e.g. logging mood several times a
day, or multiple runs in one day.

#### Streak Freezes

- Toggle - enable/disable
- Earn a freeze once every [7] days (editable)
- Limit up to [2] streak freezes accumulated (editable)
- Toggle - require a note when using a freeze

### Goal

#### Goal settings

- **Unit** (optional) - what the number measures (e.g. meters, pages, kg,
  books). If omitted, the running total is shown as a bare number.
- **Target amount** (optional) - the number you are working toward (e.g. 50,000
  meters). Optional because a user might just want to track their amount with no
  plan.
- **Start date** (optional) - when the goal begins. When set alongside target
  date and target amount, the UI shows a "ghost" on the progress bar: the
  expected linear position you should be at today, and the card turns green when
  you are on or ahead of pace, grey when behind.
- **Target date** (optional) - a deadline by which you want to reach the target.
  Once the day after it begins, a goal that has not reached its target is out of
  time and its card is shown greyed out.
- **Step size** (optional) - if set, the UI will make each log add this fixed
  number instead of a free-form entry. Useful for counting discrete things (step
  = 1 for books, or step = 0.5 for half-mile walk segments). This setting will
  make the UI act a bit more like boolean habits.

## Log entry

Every log entry records:

- **Log date** - the date the activity happened (not necessarily when it was
  logged; the user can backfill yesterday's run today)
- **Created at** - timestamp of when the entry was actually created
- **Modified at** - timestamp of when the entry was last modified
- **Tracker** - which tracker this entry belongs to
- **Value** - position in the value options list (Habits with non-empty
  options); null for binary habits (log presence = done); a number (Goals)
- **Is freeze** (Habits, optional) - marks this log as a streak freeze instead
  of a regular completion
- **Note** (optional) - free text, e.g. an excuse, a detail, or how it felt

## Implementation files

- [database.dart](../../app/lib/db/database.dart)
- [tables.dart](../../app/lib/db/tables.dart)
- [tracker_denormalized.dart](../../app/lib/features/tracker_denormalized.dart)
- [goal_status.dart](../../app/lib/features/goal_status.dart)
- [home_providers.dart](../../app/lib/features/home/home_providers.dart)
- [streak_display.dart](../../app/lib/features/home/streak_display.dart)
- [log_edit_sheet.dart](../../app/lib/features/tracker_details/log_edit_sheet.dart)
- [tracker_details_screen.dart](../../app/lib/features/tracker_details/tracker_details_screen.dart)
- [goal_edit_screen.dart](../../app/lib/features/tracker_type/goal_edit_screen.dart)
- [habit_edit_screen.dart](../../app/lib/features/tracker_type/habit_edit_screen.dart)
- [tracker_delete_button.dart](../../app/lib/features/tracker_type/tracker_delete_button.dart)
- [tracker_type_screen.dart](../../app/lib/features/tracker_type/tracker_type_screen.dart)
