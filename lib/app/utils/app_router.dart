import 'package:flutter/material.dart';

import '../presentation/weather/pages/home_page.dart';

abstract class AppRouter {
  static const String homePage = '/home';
  static const String historicalRatesPage = '/historical_rates';

  static const String initialRoute = homePage;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
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
