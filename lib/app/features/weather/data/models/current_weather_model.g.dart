// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWeatherModel _$CurrentWeatherModelFromJson(Map<String, dynamic> json) =>
    CurrentWeatherModel(
      coord: json['coord'] == null
          ? null
          : CoordModel.fromJson(json['coord'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      base: json['base'] as String?,
      main: json['main'] == null
          ? null
          : MainWeatherModel.fromJson(json['main'] as Map<String, dynamic>),
      visibility: (json['visibility'] as num?)?.toInt(),
      wind: json['wind'] == null
          ? null
          : WindModel.fromJson(json['wind'] as Map<String, dynamic>),
      clouds: json['clouds'] == null
          ? null
          : CloudsModel.fromJson(json['clouds'] as Map<String, dynamic>),
      dt: (json['dt'] as num?)?.toInt(),
      sys: json['sys'] == null
          ? null
          : SysModel.fromJson(json['sys'] as Map<String, dynamic>),
      timezone: (json['timezone'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      cod: (json['cod'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CurrentWeatherModelToJson(
        CurrentWeatherModel instance) =>
    <String, dynamic>{
      'coord': instance.coord,
      'weather': instance.weather,
      'base': instance.base,
      'main': instance.main,
      'visibility': instance.visibility,
      'wind': instance.wind,
      'clouds': instance.clouds,
      'dt': instance.dt,
      'sys': instance.sys,
      'timezone': instance.timezone,
      'id': instance.id,
      'name': instance.name,
      'cod': instance.cod,
    };
