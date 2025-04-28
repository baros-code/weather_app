import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/network/api_manager_helpers.dart';
import '../../../../shared/domain/usecases/get_location_from_address.dart';
import '../../../auth/domain/usecases/update_user_session.dart';
import '../../domain/entities/current_weather.dart';
import '../../domain/entities/daily_forecast.dart';
import '../../domain/usecases/get_current_weather.dart';
import '../../domain/usecases/get_weekly_forecast.dart';

part 'weather_state.dart';

// TODO(Baran): Add unit tests for some widget & use cases.

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(
    this._getCurrentWeather,
    this._getWeeklyForecast,
    this._getLocationFromAddress,
    this._updateUserSession,
  ) : super(WeatherInitial());

  final GetCurrentWeather _getCurrentWeather;
  final GetWeeklyForecast _getWeeklyForecast;
  final GetLocationFromAddress _getLocationFromAddress;
  final UpdateUserSession _updateUserSession;

  CurrentWeather? currentWeatherCache;
  // Forecast data is cached by city name.
  Map<String, List<DailyForecast>> weeklyForecastCache = {};

  void getCurrentWeather(String cityName) async {
    emit(CurrentWeatherLoading());
    final result = await _getCurrentWeather(params: cityName);
    if (result.isSuccessful) {
      currentWeatherCache = result.value;
      emit(CurrentWeatherLoaded(result.value!));
      // Update user session with the current weather data.
      _updateUserSession(
        params: UserSessionParams(
          // To detect the expiration of the cache.
          date: DateTime.now(),
          currentWeather: result.value,
        ),
      );
      return;
    }
    if (result.error is ApiError) {
      final apiError = result.error as ApiError;
      emit(CurrentWeatherError(apiError.errorType));
      return;
    }
    emit(CurrentWeatherError(null));
  }

  void getWeeklyForecast(String cityName) async {
    if (weeklyForecastCache[cityName] != null) {
      emit(WeeklyForecastLoaded(weeklyForecastCache[cityName]!));
      return;
    }
    emit(WeeklyForecastLoading());
    final locationResult = await _getLocationFromAddress(params: cityName);
    if (!locationResult.isSuccessful) {
      emit(WeeklyForecastError(null));
      return;
    }
    final result = await _getWeeklyForecast(
      params: GetForecastParams(
        latitude: locationResult.value!.latitude,
        longitude: locationResult.value!.longitude,
      ),
    );
    if (result.isSuccessful) {
      weeklyForecastCache[cityName] = result.value!;
      emit(WeeklyForecastLoaded(result.value!));
      return;
    }
    if (result.error is ApiError) {
      final apiError = result.error as ApiError;
      emit(WeeklyForecastError(apiError.errorType));
      return;
    }
    emit(WeeklyForecastError(null));
  }

  void updateCurrentWeatherCache(CurrentWeather currentWeather) {
    currentWeatherCache = currentWeather;
    emit(CurrentWeatherLoaded(currentWeather));
  }
}
