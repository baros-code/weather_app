import '../../../../../core/utils/result.dart';
import '../entities/current_weather.dart';
import '../entities/daily_forecast.dart';
import '../usecases/get_weekly_forecast.dart';

abstract class WeatherRepository {
  Future<Result<CurrentWeather, Failure>> getCurrentWeather(String cityName);

  Future<Result<List<DailyForecast>, Failure>> getWeeklyForecast(
    GetForecastParams params,
  );
}
