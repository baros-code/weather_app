import 'package:get_it/get_it.dart';

import '../../../core/network/api_manager.dart';
import '../../../core/network/connectivity_manager.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/popup_manager.dart';
import '../../features/auth/presentation/controllers/splash_controller.dart';
import '../../features/weather/data/repositories/weather_repository_impl.dart';
import '../../features/weather/data/services/remote/weather_remote_service.dart';
import '../../features/weather/domain/repositories/weather_repository.dart';
import '../../features/weather/domain/usecases/get_current_weather.dart';
import '../../features/weather/presentation/controllers/home_controller.dart';
import '../../features/weather/presentation/cubit/weather_cubit.dart';
import '../data/repositories/location_repository_impl.dart';
import '../domain/repositories/location_repository.dart';
import '../domain/usecases/get_address_from_location.dart';
import '../domain/usecases/get_device_location.dart';
import '../presentation/cubit/cubit/device_location_cubit.dart';
import '../data/services/location_service.dart';

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
    locator.registerSingleton<LocationService>(DeviceLocationServiceImpl());
    locator.registerSingleton<WeatherRemoteService>(
      WeatherRemoteServiceImpl(locator()),
    );

    // Register repositories
    locator.registerSingleton<LocationRepository>(
      LocationRepositoryImpl(locator()),
    );
    locator.registerSingleton<WeatherRepository>(
      WeatherRepositoryImpl(locator()),
    );

    // Register use cases
    locator.registerFactory(
      () => GetDeviceLocation(locator(), locator()),
    );
    locator.registerFactory(
      () => GetAddressFromLocation(locator(), locator()),
    );
    locator.registerFactory(
      () => GetCurrentWeather(locator(), locator()),
    );

    // Register cubits
    locator.registerFactory(() => DeviceLocationCubit(locator(), locator()));
    locator.registerFactory(() => WeatherCubit(locator()));

    // Register controllers
    locator.registerFactory(() => SplashController(locator(), locator()));
    locator.registerFactory(() => HomeController(locator(), locator()));
  }
}
