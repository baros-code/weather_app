import 'package:flutter/material.dart';

import '../../app_config.dart';

// TODO(Baran): Save the theme mode in shared preferences.
class ThemeProvider with ChangeNotifier {
  late ThemeMode _themeMode = ThemeMode.system;

  late final ThemeData lightTheme = AppConfig.lightTheme;
  late final ThemeData darkTheme = AppConfig.darkTheme;

  ThemeData get currentTheme =>
      _themeMode == ThemeMode.dark ? darkTheme : lightTheme;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleThemeMode() {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
