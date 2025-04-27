import '../../../../../../core/network/api_manager_helpers.dart';
import '../../models/current_weather_model.dart';

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

  static ApiCall getWeatherForecast() {
    return ApiCall(
      method: ApiMethod.get,
      path: '/3.0/onecall',
    );
  }
}
