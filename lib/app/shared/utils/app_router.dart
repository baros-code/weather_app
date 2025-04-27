import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/weather/presentation/pages/home_page.dart';
import '../data/services/location_service.dart';

abstract class AppRouter {
  static const String splashPage = '/splash';
  static const String homePage = '/home';

  static const String initialRoute = splashPage;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return MaterialPageRoute(
          builder: (_) => SplashPage(),
        );
      case homePage:
        return MaterialPageRoute(
          builder: (_) => PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop) {
                SystemNavigator.pop();
              }
            },
            child: HomePage(
              params: settings.arguments as Address?,
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
