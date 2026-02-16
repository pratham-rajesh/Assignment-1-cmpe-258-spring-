import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_summary.freezed.dart';
part 'daily_summary.g.dart';

@freezed
class DailySummary with _$DailySummary {
  const factory DailySummary({
    required DateTime date,
    required int totalMl,
    required bool goalMet,
  }) = _DailySummary;

  factory DailySummary.fromJson(Map<String, dynamic> json) =>
      _$DailySummaryFromJson(json);
}
