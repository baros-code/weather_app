import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/current_weather.dart';
import '../../../../domain/usecases/get_current_weather.dart';

part 'weather_state.dart';

// TODO(Baran): Implement caching for weather data using Hive or SharedPreferences.

// TODO(Baran): Add unit tests for some widget & use cases.

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._getCurrentWeather) : super(WeatherInitial());

  final GetCurrentWeather _getCurrentWeather;

  void getCurrentWeather(String cityName) async {
    emit(CurrentWeatherLoading());
    final result = await _getCurrentWeather(params: cityName);
    if (result.isSuccessful) {
      emit(CurrentWeatherLoaded(result.value!));
    }
    emit(CurrentWeatherError());
  }
}
