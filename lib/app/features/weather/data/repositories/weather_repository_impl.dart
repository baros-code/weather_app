import '../../../../../core/utils/result.dart';
import '../../domain/entities/current_weather.dart';
import '../../domain/entities/daily_forecast.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../domain/usecases/get_weekly_forecast.dart';
import '../services/remote/weather_remote_service.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this._weatherRemoteService);

  final WeatherRemoteService _weatherRemoteService;

  @override
  Future<Result<CurrentWeather, Failure>> getCurrentWeather(
    String cityName,
  ) async {
    try {
      final result = await _weatherRemoteService.getCurrentWeather(cityName);
      if (result.isSuccessful) {
        return Result.success(value: result.value!.toEntity());
      }
      return Result.failure(result.error!);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<DailyForecast>, Failure>> getWeeklyForecast(
    GetForecastParams params,
  ) async {
    try {
      final result = await _weatherRemoteService.getWeeklyForecast(params);
      if (result.isSuccessful) {
        return Result.success(
          value: result.value!.map((e) => e.toEntity()).toList(),
        );
      }
      return Result.failure(result.error!);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }
}
