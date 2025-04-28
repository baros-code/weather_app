import 'package:equatable/equatable.dart';

import '../../../../app_config.dart';
import '../../presentation/utils/temperature_utils.dart';
import 'temperature_summary.dart';
import 'weather.dart';

class DailyForecast extends Equatable {
  const DailyForecast({
    required this.date,
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

  final DateTime date;
  final String summary;
  final TemperatureSummary temperature;
  final TemperatureSummary feelsLike;
  final int humidity;
  final double windSpeed;
  final int windDegree;
  final List<Weather> weather;
  final int clouds;
  final double rain;

  double? get temperatureValue =>
      TemperatureUtils.kelvinToCelsius(temperature.day);

  String get temperatureLabel {
    if (temperatureValue == null) {
      return AppConfig.defaultString;
    }
    return '${temperatureValue!.toStringAsFixed(0)}°C';
  }

  String get weatherIconUrl {
    if (weather.firstOrNull?.icon == null) {
      return AppConfig.defaultString;
    }
    return '${AppConfig.imageBaseUrl}/${weather.first.icon}@2x.png';
  }

  String get humidityLabel {
    return '$humidity%';
  }

  String get windSpeedLabel {
    return '${windSpeed.toStringAsFixed(1)} km/h';
  }

  String get visibilityLabel {
    return '${(humidity / 100).toStringAsFixed(2)} km';
  }

  String get windDirectionLabel {
    return '$windDegree°';
  }

  @override
  List<Object?> get props => [
        summary,
        temperature,
        feelsLike,
        humidity,
        windSpeed,
        weather,
        clouds,
        rain,
      ];
}
