import '../../../../../core/utils/result.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/daily_forecast.dart';
import '../repositories/weather_repository.dart';

class GetWeeklyForecast
    extends UseCase<GetForecastParams, List<DailyForecast>, void> {
  GetWeeklyForecast(this._weatherRepository, super.logger);

  final WeatherRepository _weatherRepository;

  @override
  Future<Result<List<DailyForecast>, Failure>> execute({
    GetForecastParams? params,
  }) {
    return _weatherRepository.getWeeklyForecast(params!);
  }
}

class GetForecastParams {
  GetForecastParams({
    required this.latitude,
    required this.longitude,
    this.excludeCurrent = true,
    this.excludeMinutely = true,
    this.excludeHourly = true,
  });

  final double latitude;
  final double longitude;
  final bool excludeCurrent;
  final bool excludeMinutely;
  final bool excludeHourly;
}
