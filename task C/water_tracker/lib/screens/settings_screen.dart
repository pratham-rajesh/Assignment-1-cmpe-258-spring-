import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import '../models/app_settings.dart';
import '../widgets/glass_card.dart';
import '../widgets/glass_button.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Text(
            'Settings',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0277BD),
              shadows: [
                Shadow(
                  color: Colors.white.withOpacity(0.5),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily Goal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0277BD),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _formatAmount(settings.dailyGoalMl, settings.unit),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0277BD),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showGoalDialog(context, ref, settings),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.3),
                              Colors.white.withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                            width: 1.5,
                          ),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                            color: Color(0xFF0277BD),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Unit',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0277BD),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _UnitButton(
                        label: 'Milliliters (ml)',
                        isSelected: settings.unit == Unit.ml,
                        onTap: () {
                          if (settings.unit != Unit.ml) {
                            HapticFeedback.lightImpact();
                            ref.read(settingsProvider.notifier).toggleUnit();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _UnitButton(
                        label: 'Ounces (oz)',
                        isSelected: settings.unit == Unit.oz,
                        onTap: () {
                          if (settings.unit != Unit.oz) {
                            HapticFeedback.lightImpact();
                            ref.read(settingsProvider.notifier).toggleUnit();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Reminders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0277BD),
                      ),
                    ),
                    Switch(
                      value: settings.remindersEnabled,
                      onChanged: (value) {
                        HapticFeedback.lightImpact();
                        ref.read(settingsProvider.notifier).toggleReminders();
                      },
                      activeColor: const Color(0xFF4FC3F7),
                    ),
                  ],
                ),
                if (settings.remindersEnabled) ...[
                  const SizedBox(height: 20),
                  _ReminderSetting(
                    label: 'Start Time',
                    value: _formatHour(settings.reminderStartHour),
                    onTap: () => _showTimePickerDialog(
                      context,
                      ref,
                      settings.reminderStartHour,
                      isStartTime: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ReminderSetting(
                    label: 'End Time',
                    value: _formatHour(settings.reminderEndHour),
                    onTap: () => _showTimePickerDialog(
                      context,
                      ref,
                      settings.reminderEndHour,
                      isStartTime: false,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ReminderSetting(
                    label: 'Interval',
                    value: 'Every ${settings.reminderIntervalHours} hours',
                    onTap: () => _showIntervalDialog(context, ref, settings),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: Text(
              'Water Tracker v1.0.0',
              style: TextStyle(
                color: const Color(0xFF0277BD).withOpacity(0.5),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showGoalDialog(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) {
    final controller = TextEditingController(
      text: settings.unit == Unit.ml
          ? settings.dailyGoalMl.toString()
          : (settings.dailyGoalMl / 29.5735).round().toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFE3F2FD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Daily Goal',
          style: TextStyle(color: Color(0xFF0277BD)),
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(
            labelText: settings.unit == Unit.ml ? 'Goal (ml)' : 'Goal (oz)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final value = int.tryParse(controller.text);
              if (value != null && value > 0) {
                final goalMl = settings.unit == Unit.oz
                    ? (value * 29.5735).round()
                    : value;
                ref.read(settingsProvider.notifier).updateDailyGoal(goalMl);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showTimePickerDialog(
    BuildContext context,
    WidgetRef ref,
    int currentHour,
    {required bool isStartTime}
  ) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: currentHour, minute: 0),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4FC3F7),
            ),
          ),
          child: child!,
        );
      },
    ).then((time) {
      if (time != null) {
        HapticFeedback.lightImpact();
        if (isStartTime) {
          ref.read(settingsProvider.notifier).updateReminderSettings(
                startHour: time.hour,
              );
        } else {
          ref.read(settingsProvider.notifier).updateReminderSettings(
                endHour: time.hour,
              );
        }
      }
    });
  }

  void _showIntervalDialog(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFE3F2FD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Reminder Interval',
          style: TextStyle(color: Color(0xFF0277BD)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [1, 2, 3, 4, 6].map((hours) {
            return ListTile(
              title: Text('Every $hours hour${hours > 1 ? 's' : ''}'),
              trailing: settings.reminderIntervalHours == hours
                  ? const Icon(Icons.check, color: Color(0xFF4FC3F7))
                  : null,
              onTap: () {
                HapticFeedback.lightImpact();
                ref.read(settingsProvider.notifier).updateReminderSettings(
                      intervalHours: hours,
                    );
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  String _formatAmount(int ml, Unit unit) {
    if (unit == Unit.oz) {
      final oz = (ml / 29.5735).round();
      return '$oz oz';
    }
    return '$ml ml';
  }

  String _formatHour(int hour) {
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:00 $period';
  }
}

class _UnitButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _UnitButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? [
                    const Color(0xFF4FC3F7).withOpacity(0.4),
                    const Color(0xFF29B6F6).withOpacity(0.3),
                  ]
                : [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.1),
                  ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4FC3F7).withOpacity(0.6)
                : Colors.white.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF0277BD),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _ReminderSetting extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ReminderSetting({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: const Color(0xFF0277BD).withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF0277BD),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right,
                  color: const Color(0xFF0277BD).withOpacity(0.5),
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
