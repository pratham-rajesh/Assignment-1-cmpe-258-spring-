import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/water_provider.dart';
import '../providers/settings_provider.dart';
import '../models/app_settings.dart';
import '../widgets/glass_card.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final last7Days = ref.watch(last7DaysProvider);
    final currentStreak = ref.watch(currentStreakProvider);
    final settings = ref.watch(settingsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Text(
            'History',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Current Streak',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0277BD),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF4FC3F7).withOpacity(0.3),
                            const Color(0xFF29B6F6).withOpacity(0.2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            color: Color(0xFFFF6F00),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$currentStreak days',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0277BD),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Last 7 Days',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0277BD),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: (settings.dailyGoalMl * 1.2),
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() >= 0 &&
                                  value.toInt() < last7Days.length) {
                                final date = last7Days[value.toInt()].date;
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    DateFormat('E').format(date).substring(0, 1),
                                    style: TextStyle(
                                      color: const Color(0xFF0277BD)
                                          .withOpacity(0.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              if (settings.unit == Unit.oz) {
                                final oz = (value / 29.5735).round();
                                return Text(
                                  '$oz',
                                  style: TextStyle(
                                    color: const Color(0xFF0277BD)
                                        .withOpacity(0.7),
                                    fontSize: 10,
                                  ),
                                );
                              }
                              return Text(
                                '${value.toInt()}',
                                style: TextStyle(
                                  color:
                                      const Color(0xFF0277BD).withOpacity(0.7),
                                  fontSize: 10,
                                ),
                              );
                            },
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: settings.dailyGoalMl / 4,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.white.withOpacity(0.2),
                            strokeWidth: 1,
                          );
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: last7Days.asMap().entries.map((entry) {
                        final index = entry.key;
                        final summary = entry.value;
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: summary.totalMl.toDouble(),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: summary.goalMet
                                    ? [
                                        const Color(0xFF4FC3F7),
                                        const Color(0xFF29B6F6),
                                      ]
                                    : [
                                        const Color(0xFF4FC3F7)
                                            .withOpacity(0.4),
                                        const Color(0xFF29B6F6)
                                            .withOpacity(0.3),
                                      ],
                              ),
                              width: 20,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(4),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4FC3F7),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Goal Met',
                        style: TextStyle(
                          color: const Color(0xFF0277BD).withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4FC3F7).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Goal Not Met',
                        style: TextStyle(
                          color: const Color(0xFF0277BD).withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
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
                  'Daily Breakdown',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0277BD),
                  ),
                ),
                const SizedBox(height: 16),
                ...last7Days.reversed.map((summary) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Icon(
                          summary.goalMet
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: summary.goalMet
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFF0277BD).withOpacity(0.3),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            DateFormat('EEEE, MMM d').format(summary.date),
                            style: TextStyle(
                              color: const Color(0xFF0277BD).withOpacity(0.8),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          _formatAmount(summary.totalMl, settings.unit),
                          style: const TextStyle(
                            color: Color(0xFF0277BD),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          const SizedBox(height: 20),
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
}
