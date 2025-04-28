// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyForecastModel _$DailyForecastModelFromJson(Map<String, dynamic> json) =>
    DailyForecastModel(
      dateTime: (json['dt'] as num?)?.toInt(),
      summary: json['summary'] as String?,
      temperature: json['temp'] == null
          ? null
          : TemperatureSummaryModel.fromJson(
              json['temp'] as Map<String, dynamic>),
      feelsLike: json['feelsLike'] == null
          ? null
          : TemperatureSummaryModel.fromJson(
              json['feelsLike'] as Map<String, dynamic>),
      humidity: (json['humidity'] as num?)?.toInt(),
      windSpeed: (json['wind_speed'] as num?)?.toDouble(),
      windDegree: (json['wind_deg'] as num?)?.toInt(),
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      clouds: (json['clouds'] as num?)?.toInt(),
      rain: (json['rain'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DailyForecastModelToJson(DailyForecastModel instance) =>
    <String, dynamic>{
      'dt': instance.dateTime,
      'summary': instance.summary,
      'temp': instance.temperature,
      'feelsLike': instance.feelsLike,
      'humidity': instance.humidity,
      'wind_speed': instance.windSpeed,
      'wind_deg': instance.windDegree,
      'weather': instance.weather,
      'clouds': instance.clouds,
      'rain': instance.rain,
    };
