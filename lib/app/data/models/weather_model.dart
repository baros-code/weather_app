import 'package:json_annotation/json_annotation.dart';

import '../../app_config.dart';
import '../../domain/entities/weather.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  const WeatherModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  factory WeatherModel.fromEntity(Weather entity) {
    return WeatherModel(
      id: entity.id,
      main: entity.main,
      description: entity.description,
      icon: entity.icon,
    );
  }

  Weather toEntity() {
    return Weather(
      id: id ?? 0,
      main: main ?? AppConfig.defaultString,
      description: description ?? AppConfig.defaultString,
      icon: icon ?? AppConfig.defaultString,
    );
  }
}
