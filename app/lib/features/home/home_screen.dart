// Design docs:
// - docs/design/goals.md
// - docs/design/screens.md
// - docs/design/visual-effects.md

import 'dart:math';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../db/database.dart';
import '../../router.dart';
import '../../theme.dart';
import '../app_bottom_nav.dart';
import '../goal_status.dart';
import '../habit_log_actions.dart';
import '../tracker_denormalized.dart';
import '../tracker_details/log_edit_sheet.dart';
import 'home_providers.dart';
import 'milestone_utils.dart';
import 'streak_display.dart';
import '../milestones/milestone_explosion.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackersAsync = ref.watch(trackersProvider);
    final todayAsync = ref.watch(todayLogsProvider);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/logo/didit-logo.svg',
                  height: 32,
                ),
                const SizedBox(width: 4),
                // Logo title text
                Transform.translate(
                  offset: const Offset(0, 2),
                  child: Text(
                    'didone',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            centerTitle: false,
          ),
          body: trackersAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (trackers) {
              if (trackers.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/logo/didit-logo.svg',
                        height: 120,
                      ),
                      const SizedBox(height: 24),
                      const Text('No trackers yet',
                          style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () => context.navigate('/tracker-type'),
                        icon: const Icon(Icons.add),
                        label: const Text('Create your first tracker'),
                      ),
                    ],
                  ),
                );
              }
              final todayLogs = todayAsync.value ?? {};
              return _TrackerGrid(
                trackers: trackers,
                todayLogs: todayLogs,
              );
            },
          ),
          bottomNavigationBar: const AppBottomNav(current: AppTab.home),
        ),
        Offstage(
          child: Text(
            _emojis,
            style: const TextStyle(
                fontSize: _emojiFontSize, decoration: TextDecoration.none),
          ),
        ),
      ],
    );
  }
}

class _TrackerGrid extends StatelessWidget {
  final List<Tracker> trackers;
  final Map<int, List<Log>> todayLogs;

  const _TrackerGrid({
    required this.trackers,
    required this.todayLogs,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight;
        final cols = isLandscape ? 2 : 1;
        const hPad = 12.0;
        const gap = 8.0;
        final cardWidth =
            (constraints.maxWidth - hPad * 2 - (cols - 1) * gap) / cols;
        // Show ~4.5 rows so cards are compact and scrollability is clear.
        final cardHeight = ((constraints.maxHeight - hPad * 2) / 4.5)
            .clamp(110.0, double.infinity);
        final ratio = cardWidth / cardHeight;
        return GridView.count(
          crossAxisCount: cols,
          childAspectRatio: ratio,
          padding: const EdgeInsets.all(hPad),
          mainAxisSpacing: gap,
          crossAxisSpacing: gap,
          children: [
            for (var i = 0; i < trackers.length; i++)
              _TrackerCard(
                tracker: trackers[i],
                todayLogs: todayLogs[trackers[i].id] ?? [],
                prevTracker: i > 0 ? trackers[i - 1] : null,
                nextTracker: i < trackers.length - 1 ? trackers[i + 1] : null,
              ),
          ],
        );
      },
    );
  }
}

typedef _EmojiParticle = ({String emoji, double dx, double dy, double spin});

class _TrackerCard extends ConsumerStatefulWidget {
  final Tracker tracker;
  final List<Log> todayLogs;
  final Tracker? prevTracker;
  final Tracker? nextTracker;

  const _TrackerCard({
    required this.tracker,
    required this.todayLogs,
    required this.prevTracker,
    required this.nextTracker,
  });

  @override
  ConsumerState<_TrackerCard> createState() => _TrackerCardState();
}

class _TrackerCardHeader extends StatelessWidget {
  final String name;
  final String? emoji;
  final TextStyle? nameStyle;
  final TextStyle? emojiStyle;
  final Widget? trailing;

  const _TrackerCardHeader({
    required this.name,
    required this.emoji,
    required this.nameStyle,
    required this.emojiStyle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final trimmedEmoji = emoji?.trim();

    return Row(
      children: [
        if (trimmedEmoji != null && trimmedEmoji.isNotEmpty) ...[
          Text(trimmedEmoji, style: emojiStyle),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: nameStyle,
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 120),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: trailing!,
            ),
          ),
        ],
      ],
    );
  }
}

// --- Celebration knobs ---
const _particleCount = 12;
const _vxMin = -440.0;
const _vxMax = 440.0;
const _vyMin = 190.0; // minimum upward launch distance in pixels
const _vyMax = 1870.0; // maximum upward launch distance in pixels
const _minSpin = 3.0; // max rotations (in full turns, ± random)
const _maxSpin = 6.0; // max rotations (in full turns, ± random)
const _animMs = 3400; // total animation duration in milliseconds
const _fadeStart = 0.6; // progress (0–1) when fade-out begins
const _gravity = 4.25; // parabola gravity coefficient (higher = falls faster)
const _emojiFontSize = 30.0;
// All the emojis used in the app
// We need to put them in an invisible render object so they don't
// flicker as ☒ for a few moments before rendering.
const _emojis = '🎉⭐✨🌟🎊💥🔥🏃❤️🏊🧠🌡️';
// Variation selectors (e.g. U+FE0F in ❤️) are not standalone emoji, so filter them out.
final _emojiList =
    _emojis.runes.where((r) => r != 0xFE0F).map(String.fromCharCode).toList();

class _TrackerCardState extends ConsumerState<_TrackerCard>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late final AnimationController _fillAnim;
  bool _actionInFlight = false;

  Tracker get tracker => widget.tracker;
  List<Log> get todayLogs => widget.todayLogs;
  bool get done => todayLogs.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _fillAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      value: widget.todayLogs.isNotEmpty ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(_TrackerCard old) {
    super.didUpdateWidget(old);
    final wasDone = old.todayLogs.isNotEmpty;
    if (!wasDone && done) {
      _fillAnim.forward();
    } else if (wasDone && !done) {
      _fillAnim.reverse();
    }
  }

  @override
  void dispose() {
    _fillAnim.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _celebrate(int count) {
    if (!mounted) return;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final center = renderBox.localToGlobal(
      Offset(renderBox.size.width / 2, renderBox.size.height / 2),
    );

    final trackerEmoji = tracker.emoji?.trim();
    final emoji = trackerEmoji == null || trackerEmoji.isEmpty
        ? _emojiList[count % _emojiList.length]
        : trackerEmoji;
    final rng = Random();
    final particles = List.generate(
      _particleCount,
      (_) => (
        emoji: emoji,
        dx: rng.nextDouble() * (_vxMax - _vxMin) + _vxMin,
        dy: -(rng.nextDouble() * _vyMax + _vyMin),
        spin:
            (_minSpin + rng.nextDouble() * (_maxSpin - _minSpin)) * 2 * 3.14159,
      ),
    );

    _overlayEntry?.remove();
    _overlayEntry = null;
    final entry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          for (final p in particles)
            Positioned(
              left: center.dx,
              top: center.dy,
              child: _EmojiParticleWidget(particle: p),
            ),
        ],
      ),
    );
    _overlayEntry = entry;
    Overlay.of(context).insert(entry);

    Future.delayed(const Duration(milliseconds: _animMs), () {
      if (entry.mounted) entry.remove();
      if (_overlayEntry == entry) _overlayEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final trackerNameStyle = theme.textTheme.titleMedium?.copyWith(
      fontSize: (theme.textTheme.titleMedium?.fontSize ?? 16) * 1.5,
      fontWeight: FontWeight.w700,
      height: 1.05,
      color: cs.onSurface.withValues(alpha: 0.8),
    );
    final trackerEmojiStyle = kEmojiStyle.copyWith(
      fontSize: trackerNameStyle?.fontSize,
      height: trackerNameStyle?.height,
    );

    final pills = PopupMenuButton<String>(
      icon: const Icon(Icons.more_horiz, size: 28),
      tooltip: 'More options',
      onSelected: (value) {
        if (value == 'calendar') {
          context.navigate('/tracker/${tracker.id}');
        } else if (value == 'settings') {
          context.navigate(
            tracker.type == 'habit'
                ? '/habit-edit/${tracker.id}'
                : '/goal-edit/${tracker.id}',
          );
        } else if (value == 'note') {
          showLogEditSheet(context, ref, log: todayLogs.last, tracker: tracker);
        } else if (value == 'undo') {
          _undoLog(ref);
        } else if (value == 'archive') {
          _archive(context, ref);
        } else if (value == 'move_up') {
          ref.read(dbProvider).swapTrackerOrder(tracker, widget.prevTracker!);
        } else if (value == 'move_down') {
          ref.read(dbProvider).swapTrackerOrder(tracker, widget.nextTracker!);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'calendar',
          child: ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Calendar'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuItem(
          value: 'settings',
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuItem(
          value: 'archive',
          child: ListTile(
            leading: Icon(Icons.archive_outlined),
            title: Text('Archive'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        if (widget.prevTracker != null)
          const PopupMenuItem(
            value: 'move_up',
            child: ListTile(
              leading: Icon(Icons.arrow_upward),
              title: Text('Move up'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        if (widget.nextTracker != null)
          const PopupMenuItem(
            value: 'move_down',
            child: ListTile(
              leading: Icon(Icons.arrow_downward),
              title: Text('Move down'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        if (done) ...[
          PopupMenuItem(
            value: 'note',
            child: ListTile(
              leading: const Icon(Icons.note_add),
              title: const Text('Note'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          PopupMenuItem(
            value: 'undo',
            child: ListTile(
              leading: const Icon(Icons.undo),
              title: const Text('Undo'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ],
    );

    final statStyle =
        theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800);

    final ghost = _goalGhost(tracker);
    final status = goalStatus(tracker, now: DateTime.now());

    // Parse value options and compute streak up-front so both the top row
    // and bottom section can reference them.
    List<String> valueOptions = [];
    int? todayValueIdx;
    HabitStreakDisplay? streakDisplay;
    if (tracker.type == 'habit') {
      valueOptions = habitValueOptions(tracker);
      if (valueOptions.isNotEmpty && todayLogs.isNotEmpty) {
        final v = todayLogs.last.value;
        if (v != null) todayValueIdx = v.round();
      }
      final cachedStreak = tracker.habitStreak;
      final displayCachedStreak = _displayCachedHabitStreak(cachedStreak);
      final isPeriodicHabit =
          tracker.habitPeriod == 'weekly' || tracker.habitPeriod == 'monthly';
      final needsLogFallback =
          cachedStreak == null || cachedStreak <= 0 || isPeriodicHabit;
      final fallbackLogDates = needsLogFallback
          ? ref
              .watch(habitLogDatesByTrackerProvider(tracker.id))
              .maybeWhen(data: (dates) => dates, orElse: () => const <String>{})
          : const <String>{};
      streakDisplay = habitStreakDisplay(
        doneToday: done,
        logDates: {
          ...fallbackLogDates,
          for (final log in todayLogs) log.logDate,
        },
        today: DateTime.now(),
        cachedStreak: displayCachedStreak,
        period: tracker.habitPeriod,
      );
    }

    // Top-right: streak badge, goal total, or check circle.
    Widget? topRight;
    if (streakDisplay != null && streakDisplay.value > 0) {
      topRight = Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${streakDisplay.value}',
            style: theme.textTheme.displayMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(streakDisplay.suffix, style: theme.textTheme.labelSmall),
        ],
      );
    } else if (tracker.type == 'goal') {
      final total = tracker.goalRunningTotal ?? 0;
      topRight = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status == GoalStatus.completed) ...[
            Icon(Icons.emoji_events,
                size: statStyle?.fontSize, color: cs.primary),
            const SizedBox(width: 4),
          ],
          Text(_fmt(total), style: statStyle),
        ],
      );
    } else if (done) {
      topRight = const Icon(Icons.check_circle, color: kSeedColor);
    }

    Widget bottomSection;
    if (tracker.type == 'habit') {
      bottomSection = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (todayValueIdx != null && todayValueIdx < valueOptions.length) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                valueOptions[todayValueIdx],
                style: theme.textTheme.labelSmall?.copyWith(
                  color: cs.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 6),
          ],
        ],
      );
    } else {
      final target = tracker.goalTargetAmount;
      final caption = _goalCaption(status, ghost);
      bottomSection = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (target != null) ...[
            _GoalProgressBar(
              progress: ((tracker.goalRunningTotal ?? 0) / target).clamp(0, 1),
              // The pace marker only means something while there is still
              // time to catch up with it.
              ghostFraction: ghost != null && status == GoalStatus.active
                  ? (ghost.amount / target).clamp(0.0, 1.0)
                  : null,
            ),
            const SizedBox(height: 2),
          ],
          if (caption != null) ...[
            Text(caption, style: theme.textTheme.bodySmall),
            const SizedBox(height: 4),
          ],
        ],
      );
    }

    final isOnTrack =
        ghost != null && (tracker.goalRunningTotal ?? 0) >= ghost.amount;

    return AnimatedBuilder(
      animation: _fillAnim,
      builder: (context, child) {
        final t = _cardFillLevel(status, ghost != null, isOnTrack);
        final card = Card(
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          shadowColor: Colors.black.withValues(alpha: 0.35),
          color: cardGradientTop(cs, t),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  cardGradientTop(cs, t),
                  cardGradientBottom(cs, t),
                ],
              ),
            ),
            child: child,
          ),
        );
        // A goal past its deadline is history: it stays readable and loggable,
        // but drained of colour so the live trackers stand out.
        return status == GoalStatus.outOfTime
            ? ColorFiltered(colorFilter: kSpentCardFilter, child: card)
            : card;
      },
      child: InkWell(
        onTap: () => _primaryAction(context, ref),
        onLongPress: done
            ? () => showLogEditSheet(context, ref,
                log: todayLogs.last, tracker: tracker)
            : null,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TrackerCardHeader(
                    name: tracker.name,
                    emoji: tracker.emoji,
                    nameStyle: trackerNameStyle,
                    emojiStyle: trackerEmojiStyle,
                    trailing: topRight,
                  ),
                  Expanded(
                    child: ClipRect(
                      child: OverflowBox(
                        alignment: Alignment.bottomLeft,
                        maxHeight: double.infinity,
                        child: bottomSection,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: pills,
            ),
          ],
        ),
      ),
    );
  }

  String _fmt(double v) =>
      v == v.truncate() ? v.toInt().toString() : v.toStringAsFixed(1);

  /// How green the card is: 0 neutral grey, 1 logged / on pace.
  double _cardFillLevel(GoalStatus status, bool hasGhost, bool isOnTrack) {
    if (status == GoalStatus.completed) return 1;
    if (status == GoalStatus.outOfTime) return 0;
    if (hasGhost) return isOnTrack ? 1 : 0;
    return _fillAnim.value;
  }

  /// The line under a goal's progress bar: what is left to do, or how it
  /// ended. Null for an open-ended goal that is still running, which has
  /// nothing to say.
  String? _goalCaption(
      GoalStatus status, ({double amount, double fraction})? ghost) {
    final target = tracker.goalTargetAmount;
    final unit = tracker.goalUnit != null ? ' ${tracker.goalUnit}' : '';
    final label = goalStatusLabel(status);
    if (label != null) {
      if (target == null) return label;
      return '$label · ${_fmt(tracker.goalRunningTotal ?? 0)} of ${_fmt(target)}$unit';
    }
    if (target == null) return null;
    if (ghost != null) {
      return 'expected ${_fmt(ghost.amount)}$unit · out of ${_fmt(target)}$unit';
    }
    return 'out of ${_fmt(target)}$unit';
  }

  ({double amount, double fraction})? _goalGhost(Tracker t) {
    final start = t.goalStartDate;
    final end = t.goalTargetDate;
    final target = t.goalTargetAmount;
    if (start == null || end == null || target == null) return null;
    final totalMs = end.difference(start).inMilliseconds;
    if (totalMs <= 0) return null;
    final elapsedMs =
        DateTime.now().difference(start).inMilliseconds.clamp(0, totalMs);
    final fraction = elapsedMs / totalMs;
    return (amount: target * fraction, fraction: fraction);
  }

  int? _displayCachedHabitStreak(int? cachedStreak) {
    if (!done || cachedStreak == null || cachedStreak <= 0) {
      return cachedStreak;
    }

    final hasLogNewerThanTracker =
        todayLogs.any((log) => log.modifiedAt.isAfter(tracker.modifiedAt));
    return hasLogNewerThanTracker ? cachedStreak + 1 : cachedStreak;
  }

  // True for trackers that hold at most one log per day. A tap writes to the
  // DB, but `todayLogs` only catches up when the drift stream emits, so for
  // these a second tap landing inside that window would repeat the insert
  // instead of toggling. Step-size goals and Anytime habits are meant to stack
  // logs, so guarding them would silently drop real taps.
  bool get _singleLogPerDay =>
      tracker.type == 'habit' && tracker.habitAllowMultiple != true;

  Future<void> _primaryAction(BuildContext context, WidgetRef ref) async {
    final guarded = _singleLogPerDay;
    if (guarded) {
      if (_actionInFlight) return;
      _actionInFlight = true;
    }
    try {
      if (tracker.type == 'habit') {
        await _habitPrimaryAction(context, ref);
      } else {
        await _goalPrimaryAction(context, ref);
      }
    } finally {
      if (guarded) _actionInFlight = false;
    }
  }

  Future<void> _habitPrimaryAction(BuildContext context, WidgetRef ref) async {
    final db = ref.read(dbProvider);
    final existing = todayLogs.isEmpty ? null : todayLogs.last;
    final streak = await handleHabitDayTap(
      context: context,
      ref: ref,
      db: db,
      tracker: tracker,
      existing: existing,
      dateStr: todayDate(),
    );
    if (streak != null) {
      _celebrate(streak);
      if (isMilestoneNumber(streak)) _showMilestoneExplosion(streak.toString());
    }
  }

  Future<void> _goalPrimaryAction(BuildContext context, WidgetRef ref) async {
    final step = tracker.goalStepSize;
    if (step != null) {
      await _logGoalStep(ref, step);
    } else {
      await _showGoalEntry(context, ref);
    }
  }

  Future<void> _logValue(WidgetRef ref, double value) async {
    final db = ref.read(dbProvider);
    final now = DateTime.now();
    final oldTotal = tracker.goalRunningTotal ?? 0.0;
    await db.into(db.logs).insert(LogsCompanion.insert(
          trackerId: tracker.id,
          logDate: todayDate(),
          createdAt: now,
          modifiedAt: now,
          value: Value(value),
        ));
    final newTotal = await recomputeGoalTotal(db, tracker);
    _celebrate(todayLogs.length + 1);
    final target = tracker.goalTargetAmount;
    if (target != null && target > 0) {
      final milestone = goalMilestoneCrossed(oldTotal, newTotal, target);
      if (milestone != null) _showMilestoneExplosion(milestone);
    }
  }

  void _showMilestoneExplosion(String label) {
    if (!mounted) return;
    showMilestoneExplosion(context, label);
  }

  Future<void> _logGoalStep(WidgetRef ref, double step) => _logValue(ref, step);

  /// Archiving removes this card, so the snack bar — the only way back for a
  /// mis-tap — is taken from the messenger before the widget goes away.
  Future<void> _archive(BuildContext context, WidgetRef ref) async {
    final db = ref.read(dbProvider);
    final messenger = ScaffoldMessenger.of(context);
    await db.setTrackerArchived(tracker.id, true);
    messenger.showSnackBar(SnackBar(
      content: Text('${tracker.name} archived'),
      // A snack bar that carries an action defaults to persist: true, which
      // leaves it parked over the bottom nav until something is tapped. Undo
      // is an offer, not a question — it should time out like any other.
      persist: false,
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () => db.setTrackerArchived(tracker.id, false),
      ),
    ));
  }

  Future<void> _undoLog(WidgetRef ref) async {
    if (todayLogs.isEmpty || _actionInFlight) return;
    _actionInFlight = true;
    try {
      final db = ref.read(dbProvider);
      await (db.delete(db.logs)..where((l) => l.id.equals(todayLogs.last.id)))
          .go();
      if (tracker.type == 'habit') {
        await recomputeHabitStreak(db, tracker);
      } else {
        await recomputeGoalTotal(db, tracker);
      }
    } finally {
      _actionInFlight = false;
    }
  }

  Future<void> _showGoalEntry(BuildContext context, WidgetRef ref) async {
    final ctrl = TextEditingController();
    final value = await showDialog<double>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(todayLogs.isNotEmpty
            ? 'Log another ${tracker.name}'
            : 'Log ${tracker.name}'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: tracker.goalUnit ?? 'Amount',
            border: const OutlineInputBorder(),
          ),
          onSubmitted: (v) {
            final parsed = double.tryParse(v.trim());
            if (parsed != null) Navigator.pop(context, parsed);
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final v = double.tryParse(ctrl.text.trim());
              if (v != null) Navigator.pop(context, v);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (value != null) await _logValue(ref, value);
  }
}

class _GoalProgressBar extends StatelessWidget {
  final double progress;
  final double? ghostFraction;

  const _GoalProgressBar({required this.progress, this.ghostFraction});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const radius = BorderRadius.all(Radius.circular(6));
    if (ghostFraction == null) {
      return LinearProgressIndicator(
        value: progress,
        minHeight: 10,
        borderRadius: radius,
        color: cs.primary,
      );
    }
    const barH = 10.0;
    const circleD = 18.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final circleLeft =
            (ghostFraction! * width - circleD / 2).clamp(0.0, width - circleD);
        return SizedBox(
          height: circleD,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: (circleD - barH) / 2,
                height: barH,
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: barH,
                  borderRadius: radius,
                  color: cs.primary,
                ),
              ),
              Positioned(
                left: circleLeft,
                top: 0,
                child: Container(
                  width: circleD,
                  height: circleD,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cs.onSurface.withValues(alpha: 0.35),
                    border: Border.all(color: cs.surface, width: 2),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmojiParticleWidget extends StatefulWidget {
  final _EmojiParticle particle;
  const _EmojiParticleWidget({required this.particle});

  @override
  State<_EmojiParticleWidget> createState() => _EmojiParticleWidgetState();
}

class _EmojiParticleWidgetState extends State<_EmojiParticleWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: _animMs),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        child: Text(
          widget.particle.emoji,
          style: const TextStyle(
              fontSize: _emojiFontSize, decoration: TextDecoration.none),
        ),
        builder: (_, child) {
          final t = _controller.value;
          final opacity = t < _fadeStart
              ? 1.0
              : ((1.0 - t) / (1.0 - _fadeStart)).clamp(0.0, 1.0);
          return Opacity(
            opacity: opacity,
            child: Transform.translate(
              offset: Offset(
                widget.particle.dx * t,
                widget.particle.dy * (t - _gravity * t * t),
              ),
              child: Transform.rotate(
                angle: widget.particle.spin * t,
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
