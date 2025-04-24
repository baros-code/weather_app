import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'app/app_config.dart';
import 'app/presentation/utils/theme_provider.dart';
import 'app/presentation/weather/cubit/cubit/weather_cubit.dart';
import 'app/utils/app_router.dart';
import 'app/utils/service_locator.dart';
import 'core/network/api_manager.dart';
import 'core/utils/logger.dart';

void main() {
  runZonedGuarded(
    () async {
      // Load environment variables (API_KEY e.g.).
      await dotenv.load();
      // Initialize the app components.
      _initializeDependencies();
      // Handle Flutter errors.
      FlutterError.onError = _onFlutterError;
      // Run the app.
      runApp(const MainApp());
    },
    // Handle Dart errors.
    _onDartError,
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getCubitProviders(),
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            return MaterialApp(
              theme: themeProvider.lightTheme,
              darkTheme: themeProvider.darkTheme,
              themeMode: themeProvider.themeMode,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRouter.generateRoute,
              initialRoute: AppRouter.initialRoute,
              builder: _buildApp,
            );
          },
        ),
      ),
    );
  }

  Widget _buildApp(BuildContext context, Widget? child) {
    return MediaQuery(
      // Prevent system settings change font size of the app.
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: Scaffold(body: child),
    );
  }

  List<BlocProvider> _getCubitProviders() {
    return [
      BlocProvider<WeatherCubit>(
        create: (context) => locator<WeatherCubit>(),
      ),
    ];
  }
}

void _initializeDependencies() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.initialize();
  locator<ApiManager>().setup(AppConfig.apiSetupParams);
}

void _onFlutterError(FlutterErrorDetails details) {
  FlutterError.presentError(details);
  locator<Logger>().error(
    '${details.exceptionAsString()}\n${details.stack.toString()}',
  );
}

void _onDartError(Object error, StackTrace stackTrace) {
  locator<Logger>().error(
    '${error.toString()}\n${stackTrace.toString()}',
  );
}
