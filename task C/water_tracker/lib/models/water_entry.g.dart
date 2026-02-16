// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WaterEntryImpl _$$WaterEntryImplFromJson(Map<String, dynamic> json) =>
    _$WaterEntryImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      amountMl: (json['amountMl'] as num).toInt(),
    );

Map<String, dynamic> _$$WaterEntryImplToJson(_$WaterEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'amountMl': instance.amountMl,
    };
