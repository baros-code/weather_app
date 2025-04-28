import '../../../../../../core/network/api_manager.dart';
import '../../../../../../core/utils/result.dart';
import '../../../domain/usecases/get_weekly_forecast.dart';
import '../../models/current_weather_model.dart';
import '../../models/daily_forecast_model.dart';
import 'weather_api.dart';

abstract class WeatherRemoteService {
  Future<Result<CurrentWeatherModel, Failure>> getCurrentWeather(
    String cityName,
  );

  Future<Result<List<DailyForecastModel>, Failure>> getWeeklyForecast(
    GetForecastParams params,
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

  @override
  Future<Result<List<DailyForecastModel>, Failure>> getWeeklyForecast(
    GetForecastParams params,
  ) {
    return _apiManager.call(
      WeatherApi.getWeatherForecast(
        latitude: params.latitude,
        longitude: params.longitude,
        excludeCurrent: params.excludeCurrent,
        excludeMinutely: params.excludeMinutely,
        excludeHourly: params.excludeHourly,
      ),
    );
  }
}
