part of 'weather_cubit.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class CurrentWeatherLoading extends WeatherState {}

final class CurrentWeatherLoaded extends WeatherState {
  const CurrentWeatherLoaded(this.currentWeather);

  final CurrentWeather currentWeather;

  @override
  List<Object> get props => [currentWeather];
}

final class CurrentWeatherError extends WeatherState {}
