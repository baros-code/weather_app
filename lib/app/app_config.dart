import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../core/network/api_manager_helpers.dart';

class AppConfig {
  static ApiSetupParams apiSetupParams = ApiSetupParams(
    baseUrl: _apiBaseUrl,
    baseQueryParams: {'appid': _apiKey},
    retryCount: 1,
  );

  static const String _apiBaseUrl = 'https://api.openweathermap.org/data';

  static const String imageBaseUrl = 'https://openweathermap.org/img/wn/';

  static final String _apiKey = dotenv.env['API_KEY']!;

  static const String defaultString = 'N/A';
}
