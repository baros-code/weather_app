import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme_provider.dart';

extension BuildContextExt on BuildContext {
  /// Returns the current locale of the app.
  Locale get locale => Localizations.localeOf(this);

  /// Returns the theme provider of the app.
  ThemeProvider get themeProvider => Provider.of<ThemeProvider>(this);

  /// Returns the current color scheme of the app.
  ColorScheme get colorScheme => themeProvider.currentTheme.colorScheme;

  TextTheme get textTheme => themeProvider.currentTheme.textTheme;
}
