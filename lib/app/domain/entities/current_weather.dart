import 'package:equatable/equatable.dart';

import 'clouds.dart';
import 'coord.dart';
import 'main_weather.dart';
import 'sys.dart';
import 'weather.dart';
import 'wind.dart';

class CurrentWeather extends Equatable {
  const CurrentWeather({
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

  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final MainWeather? main;
  final int? visibility;
  final Wind? wind;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  factory CurrentWeather.initial() {
    return const CurrentWeather(
      coord: null,
      weather: null,
      base: null,
      main: null,
      visibility: null,
      wind: null,
      clouds: null,
      dt: null,
      sys: null,
      timezone: null,
      id: null,
      name: null,
      cod: null,
    );
  }

  @override
  List<Object?> get props => [
        coord,
        weather,
        base,
        main,
        visibility,
        wind,
        clouds,
        dt,
        sys,
        timezone,
        id,
        name,
        cod,
      ];
}
