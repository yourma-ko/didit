// Design docs:
// - docs/design/data-model.md
// - docs/design/screens.md

import 'dart:convert';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../db/database.dart';
import 'emoji_form_field.dart';
import 'tracker_archive_button.dart';
import 'tracker_delete_button.dart';
import '../reminders/habit_reminder.dart';
import '../reminders/reminder_fields.dart';

class HabitEditScreen extends ConsumerStatefulWidget {
  final int? trackerId;
  const HabitEditScreen({super.key, this.trackerId});

  @override
  ConsumerState<HabitEditScreen> createState() => _HabitEditScreenState();
}

class _HabitEditScreenState extends ConsumerState<HabitEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emojiController = TextEditingController();

  String _period = 'daily';
  final List<TextEditingController> _valueOptionControllers = [];
  bool _allowMultiple = false;
  bool _freezeEnabled = false;
  int _freezeEarnInterval = 7;
  int _freezeLimit = 2;
  bool _freezeRequireNote = false;
  bool _loading = false;
  bool _archived = false;
  bool _saving = false;
  HabitReminder _reminder = HabitReminder();

  bool get _isEditing => widget.trackerId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) _loadTracker();
  }

  Future<void> _loadTracker() async {
    setState(() => _loading = true);
    final db = ref.read(dbProvider);
    final tracker = await (db.select(db.trackers)
          ..where((t) => t.id.equals(widget.trackerId!)))
        .getSingle();
    if (!mounted) return;
    setState(() {
      _nameController.text = tracker.name;
      _emojiController.text = tracker.emoji ?? '';
      _archived = tracker.archived;
      _period = tracker.habitPeriod ?? 'daily';
      _reminder = HabitReminder.decode(tracker.habitReminder);
      _allowMultiple = tracker.habitAllowMultiple ?? false;
      _freezeEnabled = tracker.habitFreezeEnabled ?? false;
      _freezeEarnInterval = tracker.habitFreezeEarnInterval ?? 7;
      _freezeLimit = tracker.habitFreezeLimit ?? 2;
      _freezeRequireNote = tracker.habitFreezeRequireNote ?? false;
      if (tracker.habitValueOptions != null) {
        final opts =
            (jsonDecode(tracker.habitValueOptions!) as List).cast<String>();
        _valueOptionControllers
            .addAll(opts.map((s) => TextEditingController(text: s)));
      }
      _loading = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emojiController.dispose();
    for (final c in _valueOptionControllers) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await _persist();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Could not save habit. Please try again.')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _persist() async {
    final db = ref.read(dbProvider);
    final now = DateTime.now();

    final valueOptions = _valueOptionControllers
        .map((c) => c.text.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    final valueOptionsJson =
        valueOptions.isEmpty ? null : jsonEncode(valueOptions);
    final emoji = _optionalText(_emojiController);

    if (_isEditing) {
      await (db.update(db.trackers)
            ..where((t) => t.id.equals(widget.trackerId!)))
          .write(TrackersCompanion(
        name: Value(_nameController.text.trim()),
        emoji: Value(emoji),
        habitPeriod: Value(_period),
        habitReminder: Value(_reminder.encode()),
        habitValueOptions: Value(valueOptionsJson),
        habitAllowMultiple: Value(_allowMultiple),
        habitFreezeEnabled: Value(_freezeEnabled),
        habitFreezeEarnInterval:
            Value(_freezeEnabled ? _freezeEarnInterval : null),
        habitFreezeLimit: Value(_freezeEnabled ? _freezeLimit : null),
        habitFreezeRequireNote:
            Value(_freezeEnabled ? _freezeRequireNote : null),
        modifiedAt: Value(now),
      ));
    } else {
      final maxRow = await db
          .customSelect(
              'SELECT COALESCE(MAX(sort_order), 0) AS m FROM trackers')
          .getSingle();
      final sortOrder = maxRow.read<int>('m') + 1;

      await db.into(db.trackers).insert(TrackersCompanion.insert(
            name: _nameController.text.trim(),
            emoji: Value(emoji),
            type: 'habit',
            sortOrder: sortOrder,
            habitPeriod: Value(_period),
            habitReminder: Value(_reminder.encode()),
            habitValueOptions: Value(valueOptionsJson),
            habitAllowMultiple: Value(_allowMultiple),
            habitFreezeEnabled: Value(_freezeEnabled),
            habitFreezeEarnInterval:
                Value(_freezeEnabled ? _freezeEarnInterval : null),
            habitFreezeLimit: Value(_freezeEnabled ? _freezeLimit : null),
            habitFreezeRequireNote:
                Value(_freezeEnabled ? _freezeRequireNote : null),
            createdAt: now,
            modifiedAt: now,
          ));
    }

    final remindersSynced = await db.syncReminders();
    if (!mounted) return;
    if (!remindersSynced) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Habit saved, but reminders could not be scheduled. Reopen the app to retry.'),
      ));
    }
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed: () => context.go(
                _isEditing ? '/tracker/${widget.trackerId}' : '/tracker-type')),
        title: Text(_isEditing ? 'Edit Habit' : 'New Habit'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                  labelText: 'Name', border: OutlineInputBorder()),
              textCapitalization: TextCapitalization.sentences,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            EmojiFormField(controller: _emojiController),
            const SizedBox(height: 24),
            Text('Period', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'daily', label: Text('Daily')),
                ButtonSegment(value: 'weekly', label: Text('Weekly')),
                ButtonSegment(value: 'monthly', label: Text('Monthly')),
              ],
              selected: {_period},
              onSelectionChanged: (s) => setState(() => _period = s.first),
            ),
            const Divider(height: 32),
            ReminderFields(
              value: _reminder,
              onChanged: (value) => setState(() => _reminder = value),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Value options',
                    style: Theme.of(context).textTheme.titleMedium),
                TextButton.icon(
                  onPressed: () => setState(() =>
                      _valueOptionControllers.add(TextEditingController())),
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
            if (_valueOptionControllers.isEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'None — binary habit (done / not done)',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            else
              ..._valueOptionControllers.asMap().entries.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: e.value,
                            decoration: InputDecoration(
                              labelText: 'Option ${e.key + 1}',
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => setState(() {
                            e.value.dispose();
                            _valueOptionControllers.removeAt(e.key);
                          }),
                        ),
                      ],
                    ),
                  )),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Allow multiple logs per period'),
              value: _allowMultiple,
              onChanged: (v) => setState(() => _allowMultiple = v),
            ),
            const Divider(height: 32),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Streak freezes'),
              value: _freezeEnabled,
              onChanged: (v) => setState(() => _freezeEnabled = v),
            ),
            if (_freezeEnabled) ...[
              const SizedBox(height: 8),
              _IntField(
                label: 'Earn a freeze every N days',
                value: _freezeEarnInterval,
                onChanged: (v) => setState(() => _freezeEarnInterval = v),
              ),
              const SizedBox(height: 8),
              _IntField(
                label: 'Maximum freezes',
                value: _freezeLimit,
                onChanged: (v) => setState(() => _freezeLimit = v),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Require note when using a freeze'),
                value: _freezeRequireNote,
                onChanged: (v) => setState(() => _freezeRequireNote = v),
              ),
            ],
            const SizedBox(height: 32),
            FilledButton(
                onPressed: _saving ? null : _save,
                child: Text(_saving ? 'Saving…' : 'Save')),
            if (_isEditing) ...[
              const SizedBox(height: 8),
              TrackerArchiveButton(
                  trackerId: widget.trackerId!, archived: _archived),
              const SizedBox(height: 8),
              TrackerDeleteButton(trackerId: widget.trackerId!),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _IntField extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  const _IntField(
      {required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value.toString(),
      decoration:
          InputDecoration(labelText: label, border: const OutlineInputBorder()),
      keyboardType: TextInputType.number,
      onChanged: (s) {
        final n = int.tryParse(s);
        if (n != null && n > 0) onChanged(n);
      },
    );
  }
}

String? _optionalText(TextEditingController controller) {
  final text = controller.text.trim();
  return text.isEmpty ? null : text;
}
