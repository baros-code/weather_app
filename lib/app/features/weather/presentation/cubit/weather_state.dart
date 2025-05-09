part of 'weather_cubit.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class CurrentWeatherLoading extends WeatherState {}

class CurrentWeatherLoaded extends WeatherState {
  const CurrentWeatherLoaded(this.currentWeather);

  final CurrentWeather currentWeather;

  @override
  List<Object> get props => [currentWeather];
}

class CurrentWeatherError extends WeatherState {
  const CurrentWeatherError(this.errorType);

  final ApiErrorType? errorType;

  @override
  List<Object?> get props => [errorType];
}

class WeeklyForecastLoading extends WeatherState {}

class WeeklyForecastLoaded extends WeatherState {
  const WeeklyForecastLoaded(this.forecast);

  final List<DailyForecast> forecast;

  @override
  List<Object> get props => [forecast];
}

class WeeklyForecastError extends WeatherState {
  const WeeklyForecastError(this.errorType);

  final ApiErrorType? errorType;

  @override
  List<Object?> get props => [errorType];
}
