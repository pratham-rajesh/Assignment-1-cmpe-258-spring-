// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailySummaryImpl _$$DailySummaryImplFromJson(Map<String, dynamic> json) =>
    _$DailySummaryImpl(
      date: DateTime.parse(json['date'] as String),
      totalMl: (json['totalMl'] as num).toInt(),
      goalMet: json['goalMet'] as bool,
    );

Map<String, dynamic> _$$DailySummaryImplToJson(_$DailySummaryImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'totalMl': instance.totalMl,
      'goalMet': instance.goalMet,
    };
