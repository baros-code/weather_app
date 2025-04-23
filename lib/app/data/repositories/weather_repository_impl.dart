import '../../../core/utils/result.dart';
import '../../domain/entities/current_weather.dart';
import '../../domain/repositories/weather_repository.dart';
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
}
