import 'package:freezed_annotation/freezed_annotation.dart';

part 'water_entry.freezed.dart';
part 'water_entry.g.dart';

@freezed
class WaterEntry with _$WaterEntry {
  const factory WaterEntry({
    required String id,
    required DateTime date,
    required int amountMl,
  }) = _WaterEntry;

  factory WaterEntry.fromJson(Map<String, dynamic> json) =>
      _$WaterEntryFromJson(json);
}
