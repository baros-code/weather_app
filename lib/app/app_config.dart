import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../core/network/api_manager_helpers.dart';

class AppConfig {
  static ApiSetupParams apiSetupParams = ApiSetupParams(
    baseUrl: _apiBaseUrl,
    baseQueryParams: {'appid': _apiKey},
    retryCount: 1,
  );

  static const String _apiBaseUrl = 'https://api.openweathermap.org/data';

  static final String _apiKey = dotenv.env['API_KEY']!;

  static const String nullString = 'N/A';

  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF96416A),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Colors.blue.shade100,
      onPrimaryContainer: Color(0xFF3D0024),
      secondary: Color(0xFF735761),
      onSecondary: Color(0xFFFFFFFF),
      error: Color(0xFFBA1B1B),
      onError: Color(0xFFFFFFFF),
      surface: Color(0xFFFBFCFE),
      onSurface: Color(0xFF1C1B1F),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      displayMedium: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      displaySmall: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFFB0D0),
      onPrimary: Color(0xFF5C113B),
      primaryContainer: Colors.grey.shade900,
      onPrimaryContainer: Color(0xFFFFD8E6),
      secondary: Color(0xFFE1BDCA),
      onSecondary: Color(0xFF412A33),
      error: Color(0xFFBA1B1B),
      onError: Color(0xFFFFFFFF),
      surface: Color(0xFFFBFCFE),
      onSurface: Color(0xFF1C1B1F),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
  );
}
