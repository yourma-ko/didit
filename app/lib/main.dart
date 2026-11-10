// Design docs:
// - docs/design/goals.md
// - docs/design/tech-stack.md
// - docs/design/cloud-backup.md
// - docs/design/platform-strategy.md

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'features/home/home_providers.dart';
import 'features/settings/drive_backup_service.dart';
import 'db/database.dart';
import 'router.dart';
import 'theme.dart';
import 'features/reminders/reminder_platform.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(const ProviderScope(child: DiditApp()));
}

class DiditApp extends ConsumerStatefulWidget {
  const DiditApp({super.key});

  @override
  ConsumerState<DiditApp> createState() => _DiditAppState();
}

class _DiditAppState extends ConsumerState<DiditApp>
    with WidgetsBindingObserver {
  late final Timer _dateTimer;
  final _drive = DriveBackupService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _dateTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      ref.read(currentDateProvider.notifier).refresh();
    });
    _drive.signInSilently().then((_) => _maybeAutoBackup());
    ref.read(dbProvider).syncReminders();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ReminderPlatform.bindNotificationTap(_openReminder)
          .catchError((Object _) {
        // Tapping a stale notification must never prevent startup.
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(currentDateProvider.notifier).refresh();
      _maybeAutoBackup();
      ref.read(dbProvider).syncReminders();
    }
  }

  Future<void> _maybeAutoBackup() async {
    try {
      if (!await _drive.shouldAutoBackup()) return;
      final data = await ref.read(dbProvider).exportData();
      await _drive.backup(data);
    } catch (_) {
      // Silent — auto backup must never interrupt the user
    }
  }

  Future<void> _openReminder(int id) async {
    final db = ref.read(dbProvider);
    final tracker = await (db.select(db.trackers)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (mounted && tracker != null) router.go('/tracker/$id');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _dateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'didone',
      theme: buildAppTheme(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
