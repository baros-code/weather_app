import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/data/services/location_service.dart';
import '../../../../shared/presentation/cubit/cubit/device_location_cubit.dart';
import '../../../../shared/utils/app_router.dart';
import '../../../../shared/utils/build_context_ext.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../cubit/weather_cubit.dart';

class HomeController extends Controller<Object> {
  HomeController(
    super.logger,
    super.popupManager,
  );

  late final AuthCubit _authCubit;
  late final DeviceLocationCubit _deviceLocationCubit;
  late final WeatherCubit _weatherCubit;
  late Address currentAddress;

  @override
  void onStart() {
    super.onStart();
    _authCubit = context.read<AuthCubit>();
    _deviceLocationCubit = context.read<DeviceLocationCubit>();
    _weatherCubit = context.read<WeatherCubit>();
    currentAddress = _deviceLocationCubit.currentAddress ?? Address.newYork();
    _tryGetCurrentWeatherFromCache();
  }

  void getCurrentWeather(String cityName) {
    if (cityName.isEmpty) {
      return;
    }
    _weatherCubit.getCurrentWeather(cityName);
    // Update the current address
    currentAddress = Address(city: cityName);
  }

  void goToForecastPage() {
    Navigator.of(context).pushNamed(
      AppRouter.forecastPage,
      arguments: currentAddress,
    );
  }

  void goToSettingsPage() {
    Navigator.of(context).pushNamed(
      AppRouter.settingsPage,
      arguments: currentAddress,
    );
  }

  void showToastMessage() {
    popupManager.showToastMessage(context, 'Please search for a city first!');
  }

  void toggleLanguage() {
    final currentLocale = context.localizations.localeName;
    if (currentLocale == 'en') {
      context.localizationProvider.setLocale(const Locale('es'));
    } else {
      context.localizationProvider.setLocale(const Locale('en'));
    }
  }

  // Helpers
  void _tryGetCurrentWeatherFromCache() {
    if (_authCubit.currentWeatherCache != null &&
        _authCubit.currentWeatherCache!.name == currentAddress.city) {
      _weatherCubit.updateCurrentWeatherCache(_authCubit.currentWeatherCache!);
    } else {
      _weatherCubit.getCurrentWeather(currentAddress.city);
    }
  }
  // -- Helpers
}
