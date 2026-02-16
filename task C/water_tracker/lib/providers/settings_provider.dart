import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_settings.dart';
import '../services/notification_service.dart';
import 'storage_provider.dart';

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier(this._ref) : super(const AppSettings()) {
    _loadSettings();
  }

  final Ref _ref;

  Future<void> _loadSettings() async {
    final storage = await _ref.read(storageServiceProvider.future);
    state = await storage.loadSettings();
    
    if (state.remindersEnabled) {
      await _scheduleReminders();
    }
  }

  Future<void> updateDailyGoal(int goalMl) async {
    state = state.copyWith(dailyGoalMl: goalMl);
    await _saveSettings();
  }

  Future<void> toggleUnit() async {
    state = state.copyWith(
      unit: state.unit == Unit.ml ? Unit.oz : Unit.ml,
    );
    await _saveSettings();
  }

  Future<void> toggleReminders() async {
    final newEnabled = !state.remindersEnabled;
    state = state.copyWith(remindersEnabled: newEnabled);
    
    if (newEnabled) {
      await NotificationService.instance.requestPermissions();
      await _scheduleReminders();
    } else {
      await NotificationService.instance.cancelAllReminders();
    }
    
    await _saveSettings();
  }

  Future<void> updateReminderSettings({
    int? startHour,
    int? endHour,
    int? intervalHours,
  }) async {
    state = state.copyWith(
      reminderStartHour: startHour ?? state.reminderStartHour,
      reminderEndHour: endHour ?? state.reminderEndHour,
      reminderIntervalHours: intervalHours ?? state.reminderIntervalHours,
    );
    
    if (state.remindersEnabled) {
      await _scheduleReminders();
    }
    
    await _saveSettings();
  }

  Future<void> _scheduleReminders() async {
    await NotificationService.instance.scheduleReminders(
      startHour: state.reminderStartHour,
      endHour: state.reminderEndHour,
      intervalHours: state.reminderIntervalHours,
    );
  }

  Future<void> _saveSettings() async {
    final storage = await _ref.read(storageServiceProvider.future);
    await storage.saveSettings(state);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>(
  (ref) => SettingsNotifier(ref),
);
