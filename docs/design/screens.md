# Screens

## Tracker Types & Input Modes

**Tracker types (design terminology):**

- **Periodic Habit** – one log per period (day, week, etc.); streak-based.
  Previously called just "Habit."
- **Anytime Habit** – unlimited logs per period; event-based count. Not
  streak-based.

**Value input modes:**

- **Toggle** – few options (≤3). Tapping cycles through values inline without
  opening a dialog.
- **Pick** – many options (>3). Always opens a dialog to choose a value.

K = 3, matching the `habitValueOptionsCycleMax` constant in code.

---

## Tap & Long-Press Behavior

The rules below apply identically to home screen cards and the calendar day
view.

| State                                | Toggle (≤K options)                             | Pick (>K options)                               |
| ------------------------------------ | ----------------------------------------------- | ----------------------------------------------- |
| Periodic Habit, unlogged             | tap cycles in (logs immediately)                | tap opens value picker                          |
| Periodic Habit, logged, mid-cycle    | tap cycles to next value                        | —                                               |
| Periodic Habit, logged, end of cycle | tap opens the log editor                        | tap opens value picker + delete                 |
| Anytime Habit, unlogged              | tap opens value picker                          | tap opens value picker                          |
| Anytime Habit, logged                | tap opens: Add new / Update (→ full log editor) | tap opens: Add new / Update (→ full log editor) |

**Long press** on any entry (home screen card or calendar day) opens the full
log editor (notes, timestamps, etc.).

**Key implications:**

- Cycling exists for Periodic Habit toggles on both surfaces, but reaching the
  end of the cycle opens the log editor (rather than silently clearing the
  entry). A value picker there would only re-offer the values just cycled past,
  so the tap lands on the editor, where the note, timestamps and delete are.
- Anytime Habit tap behavior is always a dialog regardless of Toggle or Pick,
  because the app cannot distinguish "change value" from "add new entry" from a
  tap alone.

### Log editor

A bottom sheet for one log entry: created/modified timestamps, value, note, and
a Delete button. It has no Save button — every edit is written as you make it
(typing is written once you pause, a chip or timestamp the moment you pick it),
so closing the sheet, or swiping it away mid-word, keeps what you wrote.

---

## Home

Tracker cards - if you have 1 tracker it's full screen, 2 splits top/bottom, 3–4
splits into quarters, 5+ shows each tracker as a row. Each card shows:

- Done today or not (hinted visually, not text)
- **Periodic Habit**: current streak count (shows yesterday's value, updates
  after done). Shows "X days since last log" instead of streak number when not
  done in more than one cycle.
- **Goal**: running total, with a progress bar toward the target if one is set.
  A goal that reached its target shows a trophy beside the total and keeps the
  green card; one whose target date passed without reaching it fades to grey and
  drops the pace marker, since there is no longer a pace to keep. Reaching the
  target late still counts as reached. Both stay tappable — a finished goal can
  still be logged.
- Button to set a note
- Button to go to Tracker Details screen

Tap and long-press behavior on cards follows the shared rules defined in
[Tap & Long-Press Behavior](#tap--long-press-behavior).

Trackers can be reordered with the triple-dot menu (move up or down options).

Bottom navigation row with icons, shared by Home, Settings and Archive:

- Settings screen
- Home screen
- Archive screen
- "+" add a new tracker → Tracker Type screen

## Tracker Details (Calendar view)

- Current status in big font (streak count for Habits; running total for Goals)
- **Goal**: a "Goal reached" or "Out of time" badge once the goal is finished
- **Habit**: buttons for all value options to log today's entry, or a single tap
  for binary habits
- **Goal**: numeric entry (or a single tap for fixed-step goals) to log a new
  entry
- Button - Mass Edit
- Button - Edit Tracker (goes to Tracker Edit for change name, type settings,
  freeze config)
- Button - Calendar View
- **Logged values** (habits with value options): how many logs landed on each
  option — how many runs vs cycles, how many 5-mood days — as a bar per option
  with its count and share of all logs. Options that were never picked are left
  out; logs with no usable value get one "No value" row so the counts still add
  up to the total.
- List of recent log entries with time, date, and value

## Tracker Create or Edit

### Common settings

- Name (required)
- Emoji (optional, stored separately from the name)
- Celebration settings
  - Toggle - enable/disable
  - Random emoji (when disabled, shows "Emoji set" text box for customizing
    celebration particles)
- Button - Archive (or Restore, when the tracker is already archived)
- Button - Delete (scary warning with double confirmation)

### Create or edit habit

Edit all the common tracker settings.

Select period (see [data model](data-model.md#schedule)).

Configure value options: leave empty for a binary habit, or add ordered labels
(e.g. "1 / 2 / 3 / 4 / 5" for mood).

Configure streak freezes (see [data model](data-model.md#streak-freezes)).

On Android, configure an optional local reminder: enable/disable, select the
local time and every day or selected weekdays. At least one day must remain
selected. The schedule is independent of the habit period. The form reports
blocked notification/exact-alarm permissions and links to Android settings.
See [reminder behavior and APK installation](../habit-reminders.md).

### Create or edit Goal

Edit all the common tracker settings.

- Unit (optional) - what the number measures (e.g. km, meters, books)
- Target amount (optional) - the number to reach
- Target date (optional) - deadline to reach the target
- Step size (optional) - fixed amount added per log; free-form entry if absent

## Tracker Calendar View

Calendar widget where you can navigate to a specific year/date and see or edit
the log value on that date. Days of a rated habit are shaded by their value —
later options are more saturated — so a month reads as a heatmap, keyed by the
Logged values breakdown below it. Tap and long-press behavior on calendar day
cells follows the same shared rules as home screen cards — see
[Tap & Long-Press Behavior](#tap--long-press-behavior).

## Archive

Trackers that were put away without deleting their history. Reached from the
bottom navigation row.

- One row per archived tracker: emoji, name, and a one-line summary (best streak
  for a Habit, running total for a Goal)
- Button - Restore, which puts the tracker back on the home screen
- Tapping a row opens its Tracker Details, so the history stays readable
- Empty state explains where the archive action lives

A tracker is archived from its home card menu (with an Undo snack bar) or from
the Archive button on its edit screen. Archiving only hides the tracker: its
logs, streaks and totals are untouched, and backups carry the archived flag.

## Settings

- **Google Drive Backup** section: sign in with Google, back up to Drive,
  restore from Drive
- Back up data button (local export via share sheet)
- Restore from backup button (loads file, big scary "wipe all data?" modal)
- App version
- Link to GitHub

## Mass Edit

- Start date selector
- End date selector
- Value selector (enum values or number, depending on tracker type, also
  possible to clear the date range)
- Button - Save
- Button - Cancel

## Tracker Type

Two sections: **Templates** (above) and **Custom** (below).

### Templates

Compact tappable cards that pre-fill the relevant edit screen so the user only
needs to confirm or tweak. Examples:

- **Daily cardio** – daily habit with (Run, Bike, Swim) options
- **Track mood daily** – daily habit with 5 value options (1–5)
- **Swim 50 km this year** – goal, unit "km", target 50, target date Dec 31 of
  the current year
- **4 pull-ups a day** – goal, unit "reps", target calculated as 4 times the
  number of days from today through Dec 31 of the current year, target date Dec
  31

### Custom

- **Habit** - do repeatedly on a schedule; each log is binary ("done") or a
  rating (e.g. 1–5 for mood); the streak count is tracked. Tapping this will
  open the Habit edit screen with no pre-filled values.
- **Goal** - accumulate toward a target; each log adds to a running total (e.g.
  meters swum, books read). Tapping this will open the Goal edit screen with no
  pre-filled values.

## Onboarding (First Run)

Shown only when the user has zero active trackers.

Core message: "Welcome! Start tracking your first milestone in 30 seconds."

Call to action: A prominent centered "+" button or "Create your first tracker"
button that leads directly to the Tracker Type screen.

## Implementation files

- [router.dart](../../app/lib/router.dart)
- [home_screen.dart](../../app/lib/features/home/home_screen.dart)
- [tracker_details_screen.dart](../../app/lib/features/tracker_details/tracker_details_screen.dart)
- [mass_edit_screen.dart](../../app/lib/features/tracker_details/mass_edit_screen.dart)
- [tracker_type_screen.dart](../../app/lib/features/tracker_type/tracker_type_screen.dart)
- [habit_edit_screen.dart](../../app/lib/features/tracker_type/habit_edit_screen.dart)
- [goal_edit_screen.dart](../../app/lib/features/tracker_type/goal_edit_screen.dart)
- [settings_screen.dart](../../app/lib/features/settings/settings_screen.dart)
- [log_edit_sheet.dart](../../app/lib/features/tracker_details/log_edit_sheet.dart)
- [value_breakdown.dart](../../app/lib/features/tracker_details/value_breakdown.dart)
- [goal_status.dart](../../app/lib/features/goal_status.dart)
- [app_bottom_nav.dart](../../app/lib/features/app_bottom_nav.dart)
- [archive_screen.dart](../../app/lib/features/archive/archive_screen.dart)
- [tracker_archive_button.dart](../../app/lib/features/tracker_type/tracker_archive_button.dart)
