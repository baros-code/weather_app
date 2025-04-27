import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/current_weather.dart';
import 'clouds_model.dart';
import 'coord_model.dart';
import 'main_weather_model.dart';
import 'sys_model.dart';
import 'weather_model.dart';
import 'wind_model.dart';

part 'current_weather_model.g.dart';

@JsonSerializable()
class CurrentWeatherModel {
  CurrentWeatherModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  final CoordModel? coord;
  final List<WeatherModel>? weather;
  final String? base;
  final MainWeatherModel? main;
  final int? visibility;
  final WindModel? wind;
  final CloudsModel? clouds;
  final int? dt;
  final SysModel? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherModelToJson(this);

  factory CurrentWeatherModel.fromEntity(CurrentWeather entity) {
    return CurrentWeatherModel(
      coord: entity.coord != null ? CoordModel.fromEntity(entity.coord!) : null,
      weather: entity.weather?.map(WeatherModel.fromEntity).toList(),
      base: entity.base,
      main: entity.main != null
          ? MainWeatherModel.fromEntity(entity.main!)
          : null,
      visibility: entity.visibility,
      wind: entity.wind != null ? WindModel.fromEntity(entity.wind!) : null,
      clouds:
          entity.clouds != null ? CloudsModel.fromEntity(entity.clouds!) : null,
      dt: entity.dt,
      sys: entity.sys != null ? SysModel.fromEntity(entity.sys!) : null,
      timezone: entity.timezone,
      id: entity.id,
      name: entity.name,
      cod: entity.cod,
    );
  }

  CurrentWeather toEntity() {
    return CurrentWeather(
      coord: coord?.toEntity(),
      weather: weather?.map((e) => e.toEntity()).toList(),
      base: base,
      main: main?.toEntity(),
      visibility: visibility,
      wind: wind?.toEntity(),
      clouds: clouds?.toEntity(),
      dt: dt,
      sys: sys?.toEntity(),
      timezone: timezone,
      id: id,
      name: name,
      cod: cod,
    );
  }
}
