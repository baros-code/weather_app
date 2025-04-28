import 'package:json_annotation/json_annotation.dart';

import '../../../../app_config.dart';
import '../../domain/entities/daily_forecast.dart';
import '../../domain/entities/temperature_summary.dart';
import 'temperature_summary_model.dart';
import 'weather_model.dart';

part 'daily_forecast_model.g.dart';

@JsonSerializable()
class DailyForecastModel {
  DailyForecastModel({
    required this.dateTime,
    required this.summary,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.windDegree,
    required this.weather,
    required this.clouds,
    required this.rain,
  });

  @JsonKey(name: 'dt')
  final int? dateTime;
  final String? summary;
  @JsonKey(name: 'temp')
  final TemperatureSummaryModel? temperature;
  final TemperatureSummaryModel? feelsLike;
  final int? humidity;
  @JsonKey(name: 'wind_speed')
  final double? windSpeed;
  @JsonKey(name: 'wind_deg')
  final int? windDegree;
  final List<WeatherModel>? weather;
  final int? clouds;
  final double? rain;

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) =>
      _$DailyForecastModelFromJson(json);

  Map<String, dynamic> toJson() => _$DailyForecastModelToJson(this);

  factory DailyForecastModel.fromEntity(DailyForecast entity) {
    return DailyForecastModel(
      dateTime: entity.date.millisecondsSinceEpoch ~/ 1000,
      summary: entity.summary,
      temperature: TemperatureSummaryModel.fromEntity(entity.temperature),
      feelsLike: TemperatureSummaryModel.fromEntity(entity.feelsLike),
      humidity: entity.humidity,
      windSpeed: entity.windSpeed,
      windDegree: entity.windDegree,
      weather: entity.weather.map(WeatherModel.fromEntity).toList(),
      clouds: entity.clouds,
      rain: entity.rain,
    );
  }

  DailyForecast toEntity() {
    return DailyForecast(
      date: dateTime != null
          ? DateTime.fromMillisecondsSinceEpoch(dateTime! * 1000)
          : DateTime(0),
      summary: summary ?? AppConfig.defaultString,
      temperature: temperature?.toEntity() ?? TemperatureSummary.initial(),
      feelsLike: feelsLike?.toEntity() ?? TemperatureSummary.initial(),
      humidity: humidity ?? 0,
      windSpeed: windSpeed ?? 0,
      windDegree: windDegree ?? 0,
      weather: weather?.map((e) => e.toEntity()).toList() ?? [],
      clouds: clouds ?? 0,
      rain: rain ?? 0,
    );
  }
}
