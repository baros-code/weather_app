import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/temperature_summary.dart';

part 'temperature_summary_model.g.dart';

@JsonSerializable()
class TemperatureSummaryModel {
  TemperatureSummaryModel({
    required this.day,
    required this.min,
    required this.max,
    required this.eve,
    required this.morn,
    required this.night,
  });

  final double? day;
  final double? min;
  final double? max;
  final double? eve;
  final double? morn;
  final double? night;

  factory TemperatureSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$TemperatureSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureSummaryModelToJson(this);

  factory TemperatureSummaryModel.fromEntity(TemperatureSummary entity) {
    return TemperatureSummaryModel(
      day: entity.day,
      min: entity.min,
      max: entity.max,
      eve: entity.eve,
      morn: entity.morn,
      night: entity.night,
    );
  }

  TemperatureSummary toEntity() {
    return TemperatureSummary(
      day: day ?? 0,
      min: min ?? 0,
      max: max ?? 0,
      eve: eve ?? 0,
      morn: morn ?? 0,
      night: night ?? 0,
    );
  }
}
