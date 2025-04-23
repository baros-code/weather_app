// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainWeatherModel _$MainWeatherModelFromJson(Map<String, dynamic> json) =>
    MainWeatherModel(
      temp: (json['temp'] as num?)?.toDouble(),
      feelsLike: (json['feelsLike'] as num?)?.toDouble(),
      tempMin: (json['tempMin'] as num?)?.toDouble(),
      tempMax: (json['tempMax'] as num?)?.toDouble(),
      pressure: (json['pressure'] as num?)?.toInt(),
      humidity: (json['humidity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MainWeatherModelToJson(MainWeatherModel instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feelsLike': instance.feelsLike,
      'tempMin': instance.tempMin,
      'tempMax': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
    };
