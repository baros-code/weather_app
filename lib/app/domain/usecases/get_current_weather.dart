import '../../../core/utils/result.dart';
import '../../../core/utils/use_case.dart';
import '../entities/current_weather.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeather extends UseCase<String, CurrentWeather, void> {
  GetCurrentWeather(this._repository, super.logger);

  final WeatherRepository _repository;

  @override
  Future<Result<CurrentWeather, Failure>> execute({String? params}) {
    return _repository.getCurrentWeather(params!);
  }
}
