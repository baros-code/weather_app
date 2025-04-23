import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/main_weather.dart';

part 'main_weather_model.g.dart';

@JsonSerializable()
class MainWeatherModel {
  const MainWeatherModel({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;

  factory MainWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$MainWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainWeatherModelToJson(this);

  factory MainWeatherModel.fromEntity(MainWeather entity) {
    return MainWeatherModel(
      temp: entity.temp,
      feelsLike: entity.feelsLike,
      tempMin: entity.tempMin,
      tempMax: entity.tempMax,
      pressure: entity.pressure,
      humidity: entity.humidity,
    );
  }

  MainWeather toEntity() {
    return MainWeather(
      temp: temp,
      feelsLike: feelsLike,
      tempMin: tempMin,
      tempMax: tempMax,
      pressure: pressure,
      humidity: humidity,
    );
  }
}
