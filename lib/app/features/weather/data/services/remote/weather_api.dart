import '../../../../../../core/network/api_manager_helpers.dart';
import '../../models/current_weather_model.dart';
import '../../models/daily_forecast_model.dart';

abstract class WeatherApi {
  static ApiCall<CurrentWeatherModel> getCurrentWeather({String? cityName}) {
    final queryParams = {'q': cityName};

    queryParams.removeWhere((key, value) => value == null);
    return ApiCall(
      method: ApiMethod.get,
      path: '/2.5/weather',
      responseMapper: (response) {
        return CurrentWeatherModel.fromJson(response);
      },
      queryParams: queryParams,
    );
  }

  static ApiCall<List<DailyForecastModel>> getWeatherForecast({
    double? latitude,
    double? longitude,
    bool? excludeCurrent,
    bool? excludeMinutely,
    bool? excludeHourly,
  }) {
    final queryParams = {
      'lat': latitude,
      'lon': longitude,
      'exclude': excludeCurrent != null ||
              excludeMinutely != null ||
              excludeHourly != null
          ? [
              if (excludeCurrent == true) 'current',
              if (excludeMinutely == true) 'minutely',
              if (excludeHourly == true) 'hourly',
            ].join(',')
          : null,
    };
    queryParams.removeWhere((key, value) => value == null);

    return ApiCall(
      method: ApiMethod.get,
      path: '/3.0/onecall',
      queryParams: queryParams,
      responseMapper: (response) {
        return (response['daily'] as List)
            .map((e) => DailyForecastModel.fromJson(e))
            .toList();
      },
    );
  }
}
