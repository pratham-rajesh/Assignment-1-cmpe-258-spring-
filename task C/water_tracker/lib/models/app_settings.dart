import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

enum Unit { ml, oz }

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(2000) int dailyGoalMl,
    @Default(Unit.ml) Unit unit,
    @Default(false) bool remindersEnabled,
    @Default(8) int reminderStartHour,
    @Default(22) int reminderEndHour,
    @Default(2) int reminderIntervalHours,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}
