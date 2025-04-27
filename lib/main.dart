import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'app/app_config.dart';
import 'app/features/weather/presentation/cubit/weather_cubit.dart';
import 'app/shared/presentation/cubit/cubit/device_location_cubit.dart';
import 'app/shared/utils/app_router.dart';
import 'app/shared/utils/localization_provider.dart';
import 'app/shared/utils/service_locator.dart';
import 'app/shared/utils/theme_provider.dart';
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
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider(),
          ),
          ChangeNotifierProvider<LocalizationProvider>(
            create: (_) => LocalizationProvider(),
          ),
        ],
        child: Consumer2<ThemeProvider, LocalizationProvider>(
          builder: (context, themeProvider, localizationProvider, _) {
            return MaterialApp(
              theme: themeProvider.lightTheme,
              darkTheme: themeProvider.darkTheme,
              themeMode: themeProvider.themeMode,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRouter.generateRoute,
              initialRoute: AppRouter.initialRoute,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: localizationProvider.locale,
              supportedLocales: const [Locale('en'), Locale('es')],
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
      BlocProvider<DeviceLocationCubit>(
        create: (context) => locator<DeviceLocationCubit>(),
      ),
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
