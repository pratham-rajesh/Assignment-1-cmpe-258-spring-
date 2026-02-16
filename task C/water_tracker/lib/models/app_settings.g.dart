// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingsImpl(
      dailyGoalMl: (json['dailyGoalMl'] as num?)?.toInt() ?? 2000,
      unit: $enumDecodeNullable(_$UnitEnumMap, json['unit']) ?? Unit.ml,
      remindersEnabled: json['remindersEnabled'] as bool? ?? false,
      reminderStartHour: (json['reminderStartHour'] as num?)?.toInt() ?? 8,
      reminderEndHour: (json['reminderEndHour'] as num?)?.toInt() ?? 22,
      reminderIntervalHours:
          (json['reminderIntervalHours'] as num?)?.toInt() ?? 2,
    );

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'dailyGoalMl': instance.dailyGoalMl,
      'unit': _$UnitEnumMap[instance.unit]!,
      'remindersEnabled': instance.remindersEnabled,
      'reminderStartHour': instance.reminderStartHour,
      'reminderEndHour': instance.reminderEndHour,
      'reminderIntervalHours': instance.reminderIntervalHours,
    };

const _$UnitEnumMap = {
  Unit.ml: 'ml',
  Unit.oz: 'oz',
};
