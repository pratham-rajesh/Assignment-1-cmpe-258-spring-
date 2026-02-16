import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/water_entry.dart';
import '../models/daily_summary.dart';
import '../models/app_settings.dart';

class StorageService {
  static const String _storageVersion = 'v1';
  static const String _entriesKey = '${_storageVersion}_water_entries';
  static const String _settingsKey = '${_storageVersion}_app_settings';
  
  final SharedPreferences _prefs;
  
  StorageService(this._prefs);
  
  static Future<StorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }
  
  Future<List<WaterEntry>> loadEntries() async {
    final String? jsonString = _prefs.getString(_entriesKey);
    if (jsonString == null) return [];
    
    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList
          .map((json) => WaterEntry.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }
  
  Future<void> saveEntries(List<WaterEntry> entries) async {
    final jsonList = entries.map((e) => e.toJson()).toList();
    await _prefs.setString(_entriesKey, json.encode(jsonList));
  }
  
  Future<AppSettings> loadSettings() async {
    final String? jsonString = _prefs.getString(_settingsKey);
    if (jsonString == null) return const AppSettings();
    
    try {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return AppSettings.fromJson(jsonMap);
    } catch (e) {
      return const AppSettings();
    }
  }
  
  Future<void> saveSettings(AppSettings settings) async {
    await _prefs.setString(_settingsKey, json.encode(settings.toJson()));
  }
  
  List<DailySummary> calculateDailySummaries(
    List<WaterEntry> entries,
    int dailyGoalMl,
  ) {
    final Map<String, int> dailyTotals = {};
    
    for (final entry in entries) {
      final dateKey = _dateKey(entry.date);
      dailyTotals[dateKey] = (dailyTotals[dateKey] ?? 0) + entry.amountMl;
    }
    
    final summaries = <DailySummary>[];
    for (final entry in dailyTotals.entries) {
      final date = DateTime.parse(entry.key);
      summaries.add(DailySummary(
        date: date,
        totalMl: entry.value,
        goalMet: entry.value >= dailyGoalMl,
      ));
    }
    
    summaries.sort((a, b) => b.date.compareTo(a.date));
    return summaries;
  }
  
  String _dateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
