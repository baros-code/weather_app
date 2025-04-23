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

  static const Color primaryColor = Colors.blueAccent;

  static const Color backgroundPrimary = Color(0xFF212121);

  static const Color backgroundSecondary = Color(0xFF303030);
}
