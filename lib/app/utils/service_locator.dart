import 'package:get_it/get_it.dart';

import '../../core/network/api_manager.dart';
import '../../core/network/connectivity_manager.dart';
import '../../core/utils/logger.dart';
import '../../core/utils/popup_manager.dart';
import '../data/repositories/weather_repository_impl.dart';
import '../data/services/remote/weather_remote_service.dart';
import '../domain/repositories/weather_repository.dart';
import '../domain/usecases/get_current_weather.dart';
import '../presentation/weather/controllers/home_controller.dart';
import '../presentation/weather/cubit/cubit/weather_cubit.dart';

final locator = GetIt.instance;

abstract class ServiceLocator {
  static void initialize() {
    // Register core dependencies
    locator
      ..registerSingleton<Logger>(LoggerImpl())
      ..registerSingleton<ConnectivityManager>(ConnectivityManagerImpl())
      ..registerSingleton<ApiManager>(ApiManagerImpl(locator(), locator()))
      ..registerSingleton(PopupManager());

    // Register services
    locator.registerSingleton<WeatherRemoteService>(
      WeatherRemoteServiceImpl(locator()),
    );

    // Register repositories
    locator.registerSingleton<WeatherRepository>(
      WeatherRepositoryImpl(locator()),
    );

    // Register use cases
    locator.registerFactory(
      () => GetCurrentWeather(locator(), locator()),
    );

    // Register cubits
    locator.registerFactory(() => WeatherCubit(locator()));

    // Register controllers
    locator.registerFactory(() => HomeController(locator(), locator()));
  }
}
