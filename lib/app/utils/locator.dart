import 'package:get_it/get_it.dart';

import '../../core/logger.dart';
import '../../core/network/api_manager.dart';
import '../../core/network/connectivity_manager.dart';
import '../../core/popup_manager.dart';

final locator = GetIt.instance;

abstract class Locator {
  static void initialize() {
    // Register core dependencies
    locator
      ..registerSingleton<Logger>(LoggerImpl())
      ..registerSingleton<ConnectivityManager>(ConnectivityManagerImpl())
      ..registerSingleton<ApiManager>(ApiManagerImpl(locator(), locator()))
      ..registerSingleton(PopupManager());

    // Register repositories

    // Register cubits
  }
}
