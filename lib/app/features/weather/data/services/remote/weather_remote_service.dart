import '../../../../../../core/network/api_manager.dart';
import '../../../../../../core/utils/result.dart';
import '../../models/current_weather_model.dart';
import 'weather_api.dart';

abstract class WeatherRemoteService {
  Future<Result<CurrentWeatherModel, Failure>> getCurrentWeather(
    String cityName,
  );
}

class WeatherRemoteServiceImpl implements WeatherRemoteService {
  WeatherRemoteServiceImpl(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<Result<CurrentWeatherModel, Failure>> getCurrentWeather(
    String cityName,
  ) {
    return _apiManager.call(WeatherApi.getCurrentWeather(cityName: cityName));
  }
}
