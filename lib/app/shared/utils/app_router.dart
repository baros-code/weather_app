import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/weather/presentation/pages/forecast_page.dart';
import '../../features/weather/presentation/pages/home_page.dart';
import '../data/services/location_service.dart';

abstract class AppRouter {
  static const String splashPage = '/splash';
  static const String homePage = '/home';
  static const String forecastPage = '/forecast';

  static const String initialRoute = splashPage;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return _slideTransitionRoute(
          SplashPage(),
        );
      case homePage:
        return _slideTransitionRoute(
          PopScope(
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
      case forecastPage:
        return _slideTransitionRoute(
          ForecastPage(
            params: settings.arguments as Address,
          ),
        );
      default:
        return _slideTransitionRoute(
          Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static PageRouteBuilder<Widget> _slideTransitionRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0); // From right to left
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
