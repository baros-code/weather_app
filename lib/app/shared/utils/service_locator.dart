import 'package:get_it/get_it.dart';

import '../../../core/network/api_manager.dart';
import '../../../core/network/connectivity_manager.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/popup_manager.dart';
import '../../features/auth/data/models/user_session_model.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/services/session_local_storage.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_user_session.dart';
import '../../features/auth/domain/usecases/update_user_session.dart';
import '../../features/auth/presentation/controllers/splash_controller.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/weather/data/repositories/weather_repository_impl.dart';
import '../../features/weather/data/services/remote/weather_remote_service.dart';
import '../../features/weather/domain/repositories/weather_repository.dart';
import '../../features/weather/domain/usecases/get_current_weather.dart';
import '../../features/weather/domain/usecases/get_weekly_forecast.dart';
import '../../features/weather/presentation/controllers/forecast_controller.dart';
import '../../features/weather/presentation/controllers/home_controller.dart';
import '../../features/weather/presentation/controllers/settings_page_controller.dart';
import '../../features/weather/presentation/cubit/weather_cubit.dart';
import '../data/repositories/location_repository_impl.dart';
import '../data/services/location_service.dart';
import '../domain/repositories/location_repository.dart';
import '../domain/usecases/get_address_from_location.dart';
import '../domain/usecases/get_device_location.dart';
import '../domain/usecases/get_location_from_address.dart';
import '../presentation/cubit/cubit/device_location_cubit.dart';

final locator = GetIt.instance;

abstract class ServiceLocator {
  static void initialize() {
    // Register core dependencies
    locator
      ..registerSingleton<Logger>(LoggerImpl())
      ..registerSingleton<ConnectivityManager>(ConnectivityManagerImpl())
      ..registerSingleton<ApiManager>(ApiManagerImpl(locator(), locator()))
      ..registerSingleton<PopupManager>(PopupManagerImpl());

    // Register services
    locator.registerSingleton<SessionLocalStorage>(
      SessionLocalStorageImpl(locator()),
    );
    locator.registerSingleton<LocationService>(DeviceLocationServiceImpl());
    locator.registerSingleton<WeatherRemoteService>(
      WeatherRemoteServiceImpl(locator()),
    );

    // Register repositories
    locator.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(locator()),
    );
    locator.registerSingleton<LocationRepository>(
      LocationRepositoryImpl(locator()),
    );
    locator.registerSingleton<WeatherRepository>(
      WeatherRepositoryImpl(locator()),
    );

    // Register use cases
    locator.registerFactory(
      () => GetUserSession(locator(), locator()),
    );
    locator.registerFactory(
      () => UpdateUserSession(locator(), locator()),
    );
    locator.registerFactory(
      () => GetDeviceLocation(locator(), locator()),
    );
    locator.registerFactory(
      () => GetAddressFromLocation(locator(), locator()),
    );
    locator.registerFactory(
      () => GetLocationFromAddress(locator(), locator()),
    );
    locator.registerFactory(
      () => GetCurrentWeather(locator(), locator()),
    );
    locator.registerFactory(
      () => GetWeeklyForecast(locator(), locator()),
    );

    // Register cubits
    locator.registerFactory(() => AuthCubit(locator()));
    locator.registerFactory(() => DeviceLocationCubit(locator(), locator()));
    locator.registerFactory(
      () => WeatherCubit(
        locator(),
        locator(),
        locator(),
        locator(),
      ),
    );

    // Register controllers
    locator.registerFactory(() => SplashController(locator(), locator()));
    locator.registerFactory(() => HomeController(locator(), locator()));
    locator.registerFactory(() => ForecastController(locator(), locator()));
    locator.registerFactory(() => SettingsPageController(locator(), locator()));

    // Register models for local storage
    locator.registerFactoryParam<UserSessionModel, Map<String, dynamic>, void>(
      (json, _) => UserSessionModel.fromJson(json),
    );
  }
}
