
import '../../../../../core/utils/result.dart';
import '../entities/current_weather.dart';

abstract class WeatherRepository {
  Future<Result<CurrentWeather, Failure>> getCurrentWeather(String cityName);
}
