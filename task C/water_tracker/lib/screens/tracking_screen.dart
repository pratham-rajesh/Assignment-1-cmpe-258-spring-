import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/water_provider.dart';
import '../providers/settings_provider.dart';
import '../models/app_settings.dart';
import '../widgets/glass_card.dart';
import '../widgets/glass_button.dart';
import '../widgets/progress_ring.dart';

class TrackingScreen extends ConsumerWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayTotal = ref.watch(todayTotalProvider);
    final settings = ref.watch(settingsProvider);
    final todayEntries = ref.watch(todayEntriesProvider);

    final progress = (todayTotal / settings.dailyGoalMl).clamp(0.0, 1.0);
    final remaining = (settings.dailyGoalMl - todayTotal).clamp(0, settings.dailyGoalMl);
    final percentage = (progress * 100).toInt();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Text(
            'Water Tracker',
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
            child: Column(
              children: [
                ProgressRing(
                  progress: progress,
                  size: 220,
                  strokeWidth: 18,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$percentage%',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0277BD),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatAmount(todayTotal, settings.unit),
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color(0xFF0277BD).withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(
                      label: 'Goal',
                      value: _formatAmount(settings.dailyGoalMl, settings.unit),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    _StatItem(
                      label: 'Remaining',
                      value: _formatAmount(remaining, settings.unit),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GlassCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quick Add',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0277BD),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _QuickAddButton(
                      amount: 100,
                      unit: settings.unit,
                      onPressed: () => _addWater(ref, 100),
                    ),
                    _QuickAddButton(
                      amount: 250,
                      unit: settings.unit,
                      onPressed: () => _addWater(ref, 250),
                    ),
                    _QuickAddButton(
                      amount: 500,
                      unit: settings.unit,
                      onPressed: () => _addWater(ref, 500),
                    ),
                    _QuickAddButton(
                      amount: 750,
                      unit: settings.unit,
                      onPressed: () => _addWater(ref, 750),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GlassButton(
                  text: 'Custom Amount',
                  icon: Icons.add,
                  isPrimary: true,
                  onPressed: () => _showCustomAmountDialog(context, ref, settings.unit),
                ),
              ],
            ),
          ),
          if (todayEntries.isNotEmpty) ...[
            const SizedBox(height: 24),
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Today\'s Log',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0277BD),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...todayEntries.take(5).map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Icon(
                            Icons.water_drop,
                            color: const Color(0xFF4FC3F7),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _formatTime(entry.date),
                            style: TextStyle(
                              color: const Color(0xFF0277BD).withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _formatAmount(entry.amountMl, settings.unit),
                            style: const TextStyle(
                              color: Color(0xFF0277BD),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            color: const Color(0xFF0277BD).withOpacity(0.5),
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              ref.read(waterProvider.notifier).removeEntry(entry.id);
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _addWater(WidgetRef ref, int amountMl) {
    HapticFeedback.mediumImpact();
    ref.read(waterProvider.notifier).addWater(amountMl);
  }

  void _showCustomAmountDialog(BuildContext context, WidgetRef ref, Unit unit) {
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFE3F2FD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Custom Amount',
          style: TextStyle(color: Color(0xFF0277BD)),
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(
            labelText: unit == Unit.ml ? 'Amount (ml)' : 'Amount (oz)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSubmitted: (value) {
            final amount = int.tryParse(value);
            if (amount != null && amount > 0) {
              final amountMl = unit == Unit.oz ? (amount * 29.5735).round() : amount;
              _addWater(ref, amountMl);
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final amount = int.tryParse(controller.text);
              if (amount != null && amount > 0) {
                final amountMl = unit == Unit.oz ? (amount * 29.5735).round() : amount;
                _addWater(ref, amountMl);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
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

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xFF0277BD).withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0277BD),
          ),
        ),
      ],
    );
  }
}

class _QuickAddButton extends StatelessWidget {
  final int amount;
  final Unit unit;
  final VoidCallback onPressed;

  const _QuickAddButton({
    required this.amount,
    required this.unit,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final displayAmount = unit == Unit.oz ? (amount / 29.5735).round() : amount;
    final unitText = unit == Unit.oz ? 'oz' : 'ml';

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
        child: Text(
          '+$displayAmount $unitText',
          style: const TextStyle(
            color: Color(0xFF0277BD),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
