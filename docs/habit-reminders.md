# Habit reminders and APK builds

Habit → Edit → Reminder: enable, choose a time and either Every day or one or
more weekdays, then Save. The schedule is independent of daily/weekly/monthly
logging and does not mark a habit complete. Disabled reminders keep their time
and days. Archiving suspends delivery; restoring resumes it. Deleting cancels it.

Settings are stored in the existing Drift database (schema 5, nullable JSON
`habit_reminder` column) and included in both local and Drive backups. Older
backups restore with reminders disabled. Imports validate schedules transactionally.
Startup, resume, save, archive/restore, deletion and backup import synchronize the
full active schedule with Android. A platform failure leaves database data intact
and is retried on startup/resume; the habit editor reports a failed schedule write.

## Android implementation

The small MethodChannel bridge uses Android AlarmManager and NotificationManager
directly. No additional Flutter runtime packages are needed. Android's own
timezone database is used, including timezone changes while Flutter is stopped.
Java time support on older Android is supplied by `desugar_jdk_libs:2.1.5`.
The minimum Android version follows Flutter (at least API 23). Android unit
tests use JUnit 4.13.2.

Each active habit has one durable one-shot alarm. The receiver delivers and
schedules the next local-calendar occurrence, without starting Flutter. Reboot,
package replacement, manual clock/timezone changes and exact-alarm access grants
rebuild alarms from the native delivery cache. A spring DST gap moves the time
forward by the gap; an autumn overlap uses its first occurrence, once per date.
Old alarms are replaced using stable tracker IDs. Notification taps open the
habit if it still exists. Missed reminders from past dates are discarded.

Android 13+ notification permission is requested when enabling reminders, not on
startup. If app/channel notifications are blocked, the form links to settings.
Exact-alarm access is optional: reminders use exact-and-allow-while-idle when
allowed and inexact-and-allow-while-idle otherwise. Without exact access Android
may delay them. Revoking exact-alarm access can remove existing exact alarms;
reopen the app to schedule the fallback. No full-screen alarms or background
service are used.

Closing the app normally (including removing it from Recents on standard Android)
does not stop alarms. Android Force stop disables alarms until the app is opened
again. Manufacturer battery restrictions can also delay or suppress delivery;
allow background activity/autostart for DidOne Habits Dev if needed.

## APK without installing Flutter locally

The `Build Habits APK` GitHub Actions workflow pins Flutter 3.44.0, JDK 17,
Ubuntu 24.04 and uses the checked-in pub lockfile and Gradle wrapper version.
It generates Drift code, formats changed Dart sources, runs analysis, all Flutter
tests, builds an APK and runs Android recurrence tests. It runs on pull requests
to main and pushes to `habits-reminders`, or manually from Actions once the
workflow exists on the default branch. This specifies the toolchain; it is not
a promise of byte-for-byte identical APKs or immutable hosted runner images.

1. Open the fork's Actions → Build Habits APK → successful run.
2. Download the `didone-habits-apk` artifact and extract `app-debug.apk`.
3. Transfer the APK to the phone, open it and allow installation from that
   browser/file manager when Android asks.
4. Open **DidOne Habits Dev**, restore a local backup if desired, and enable a
   reminder. Grant notification permission and optionally exact alarms.

The development package is `com.andluck.didit.habits.dev` and installs alongside
the official app. Export a backup from the official app before importing it here.
Its signing certificate differs from the official application's, so this APK
cannot update the official package. Never uninstall the official app to resolve
a signature mismatch before exporting your data. Local backup import/export
works independently of Google sign-in. Drive sign-in for this development
package requires separate OAuth configuration for its package and signing key.

Without a persistent signing key, hosted runners produce a fresh debug
certificate for each run. To keep development updates installable over previous
development builds, set repository secret `ANDROID_DEBUG_KEYSTORE_BASE64` to
your own debug keystore (standard alias `androiddebugkey`, store/key passwords
`android`). It is read only by non-PR runs. Keep the keystore backed up. PR
artifacts intentionally use disposable debug signing. With a different key,
export data, uninstall only the development app, reinstall and restore data.
The existing signed-release AAB workflow remains separate.

## Device acceptance checks

Automated tests cover migration from schema 4, old/new backups, invalid import
rollback, active snapshot updates/cancellation, platform-write retry, weekday
selection, week rollover, DST and timezone calculations. Before treating this as
a release, also check on a physical Android 13+ phone:

- Enable a reminder a few minutes ahead; grant permission; close the app and
  lock the phone. Confirm delivery and that tapping opens the right habit.
- Change time/days/name; confirm only the revised reminder fires. Disable,
  archive or delete; confirm pending reminders are cancelled. Restore an archive.
- Deny notifications and exact alarms; check messages, settings links and
  delayed fallback. Regrant permissions and return to the app.
- Reboot and change timezone with the app closed; confirm the next reminder
  follows the chosen local time. Check a DST transition using an emulator.
- Import a backup, reopen the app and confirm settings and alarm replacement.

Reference: [Android alarms](https://developer.android.com/develop/background-work/services/alarms)
and [notification runtime permission](https://developer.android.com/develop/ui/views/notifications/notification-permission).
