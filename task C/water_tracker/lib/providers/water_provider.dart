import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/water_entry.dart';
import '../models/daily_summary.dart';
import 'storage_provider.dart';
import 'settings_provider.dart';

class WaterNotifier extends StateNotifier<List<WaterEntry>> {
  WaterNotifier(this._ref) : super([]) {
    _loadEntries();
  }

  final Ref _ref;

  Future<void> _loadEntries() async {
    final storage = await _ref.read(storageServiceProvider.future);
    state = await storage.loadEntries();
  }

  Future<void> addWater(int amountMl) async {
    final entry = WaterEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      amountMl: amountMl,
    );
    
    state = [...state, entry];
    await _saveEntries();
  }

  Future<void> removeEntry(String id) async {
    state = state.where((entry) => entry.id != id).toList();
    await _saveEntries();
  }

  Future<void> _saveEntries() async {
    final storage = await _ref.read(storageServiceProvider.future);
    await storage.saveEntries(state);
  }

  int getTodayTotal() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    return state
        .where((entry) {
          final entryDate = DateTime(
            entry.date.year,
            entry.date.month,
            entry.date.day,
          );
          return entryDate.isAtSameMomentAs(today);
        })
        .fold(0, (sum, entry) => sum + entry.amountMl);
  }

  List<WaterEntry> getTodayEntries() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    return state.where((entry) {
      final entryDate = DateTime(
        entry.date.year,
        entry.date.month,
        entry.date.day,
      );
      return entryDate.isAtSameMomentAs(today);
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }
}

final waterProvider = StateNotifierProvider<WaterNotifier, List<WaterEntry>>(
  (ref) => WaterNotifier(ref),
);

final todayTotalProvider = Provider<int>((ref) {
  final notifier = ref.watch(waterProvider.notifier);
  ref.watch(waterProvider);
  return notifier.getTodayTotal();
});

final todayEntriesProvider = Provider<List<WaterEntry>>((ref) {
  final notifier = ref.watch(waterProvider.notifier);
  ref.watch(waterProvider);
  return notifier.getTodayEntries();
});

final dailySummariesProvider = Provider<List<DailySummary>>((ref) {
  final entries = ref.watch(waterProvider);
  final settings = ref.watch(settingsProvider);
  final storage = ref.watch(storageServiceProvider);
  
  return storage.when(
    data: (service) => service.calculateDailySummaries(
      entries,
      settings.dailyGoalMl,
    ),
    loading: () => [],
    error: (_, __) => [],
  );
});

final last7DaysProvider = Provider<List<DailySummary>>((ref) {
  final summaries = ref.watch(dailySummariesProvider);
  final now = DateTime.now();
  final sevenDaysAgo = now.subtract(const Duration(days: 6));
  
  final filtered = summaries.where((summary) {
    final summaryDate = DateTime(
      summary.date.year,
      summary.date.month,
      summary.date.day,
    );
    final compareDate = DateTime(
      sevenDaysAgo.year,
      sevenDaysAgo.month,
      sevenDaysAgo.day,
    );
    return summaryDate.isAfter(compareDate) || 
           summaryDate.isAtSameMomentAs(compareDate);
  }).toList();
  
  filtered.sort((a, b) => a.date.compareTo(b.date));
  
  final result = <DailySummary>[];
  for (int i = 0; i < 7; i++) {
    final date = sevenDaysAgo.add(Duration(days: i));
    final dateOnly = DateTime(date.year, date.month, date.day);
    
    final existing = filtered.firstWhere(
      (s) => DateTime(s.date.year, s.date.month, s.date.day)
          .isAtSameMomentAs(dateOnly),
      orElse: () => DailySummary(
        date: dateOnly,
        totalMl: 0,
        goalMet: false,
      ),
    );
    
    result.add(existing);
  }
  
  return result;
});

final currentStreakProvider = Provider<int>((ref) {
  final summaries = ref.watch(dailySummariesProvider);
  if (summaries.isEmpty) return 0;
  
  int streak = 0;
  final now = DateTime.now();
  
  for (int i = 0; i < 365; i++) {
    final checkDate = now.subtract(Duration(days: i));
    final dateOnly = DateTime(checkDate.year, checkDate.month, checkDate.day);
    
    final summary = summaries.firstWhere(
      (s) => DateTime(s.date.year, s.date.month, s.date.day)
          .isAtSameMomentAs(dateOnly),
      orElse: () => DailySummary(
        date: dateOnly,
        totalMl: 0,
        goalMet: false,
      ),
    );
    
    if (summary.goalMet) {
      streak++;
    } else {
      break;
    }
  }
  
  return streak;
});
