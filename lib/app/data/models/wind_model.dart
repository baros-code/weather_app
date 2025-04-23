import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/wind.dart';

part 'wind_model.g.dart';

@JsonSerializable()
class WindModel {
  const WindModel({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  final double? speed;
  final int? deg;
  final double? gust;

  factory WindModel.fromJson(Map<String, dynamic> json) =>
      _$WindModelFromJson(json);

  Map<String, dynamic> toJson() => _$WindModelToJson(this);

  factory WindModel.fromEntity(Wind entity) {
    return WindModel(
      speed: entity.speed,
      deg: entity.deg,
      gust: entity.gust,
    );
  }

  Wind toEntity() {
    return Wind(
      speed: speed,
      deg: deg,
      gust: gust,
    );
  }
}
