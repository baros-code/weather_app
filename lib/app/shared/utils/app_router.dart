import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/weather/presentation/pages/forecast_page.dart';
import '../../features/weather/presentation/pages/home_page.dart';
import '../data/services/location_service.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splashRoute.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.splashRoute.path,
        name: AppRoutes.splashRoute.name,
        pageBuilder: (context, state) {
          return _buildPage(page: SplashPage(), state: state);
        },
      ),
      GoRoute(
        path: AppRoutes.homeRoute.path,
        name: AppRoutes.homeRoute.name,
        pageBuilder: (context, state) {
          final address = state.extra as Address?;
          return _buildPage(
            page: PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (!didPop) {
                  SystemNavigator.pop();
                }
              },
              child: HomePage(params: address),
            ),
            state: state,
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.forecastRoute.path,
            name: AppRoutes.forecastRoute.name,
            pageBuilder: (context, state) {
              final address = state.extra as Address;
              return _buildPage(
                page: ForecastPage(params: address),
                state: state,
              );
            },
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;

  static Page<Widget> _buildPage({
    required Widget page,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          _fromRightToLeft(animation, child),
      child: page,
    );
  }

  static Widget _fromRightToLeft(Animation<double> animation, Widget child) {
    const begin = Offset(1, 0);
    const end = Offset.zero;
    const curve = Curves.ease;
    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}

enum AppRoutes {
  splashRoute('/splash'),
  homeRoute('/home'),
  forecastRoute('forecast');

  const AppRoutes(this.path);

  final String path;

  String get name => path.replaceAll('/', '');
}
