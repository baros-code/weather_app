import 'package:flutter/material.dart';

import 'theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeMode _themeMode = ThemeMode.system;

  late final ThemeData lightTheme = TAppTheme.lightTheme;
  late final ThemeData darkTheme = TAppTheme.darkTheme;

  ThemeMode get themeMode => _themeMode;

  void toggleThemeMode() {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
