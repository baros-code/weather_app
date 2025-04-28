import 'package:equatable/equatable.dart';

import '../../../../app_config.dart';
import '../../presentation/utils/temperature_utils.dart';
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

  double? get temperature => TemperatureUtils.kelvinToCelsius(main?.temp);

  String get temperatureLabel {
    if (temperature == null) {
      return AppConfig.defaultString;
    }
    return '${temperature!.toStringAsFixed(0)}°C';
  }

  String get weatherIconUrl {
    if (weather?.firstOrNull?.icon == null) {
      return AppConfig.defaultString;
    }
    return '${AppConfig.imageBaseUrl}/${weather!.first.icon}@2x.png';
  }

  String get weatherDescription =>
      weather?.firstOrNull?.description ?? AppConfig.defaultString;

  String get humidityLabel {
    if (main?.humidity == null) {
      return AppConfig.defaultString;
    }
    return '${main!.humidity}%';
  }

  String get windSpeedLabel {
    if (wind?.speed == null) {
      return AppConfig.defaultString;
    }
    return '${wind!.speed} km/h';
  }

  String get windDirectionLabel {
    if (wind?.deg == null) {
      return AppConfig.defaultString;
    }
    return '${wind!.deg}°';
  }

  String get visibilityLabel {
    if (visibility == null) {
      return AppConfig.defaultString;
    }
    return '${(visibility! / 1000).toStringAsFixed(0)} km';
  }

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
