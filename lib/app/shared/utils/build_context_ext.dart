import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'localization_provider.dart';
import 'theme_provider.dart';

extension BuildContextExt on BuildContext {
  /// Returns the localization provider of the app.
  LocalizationProvider get localizationProvider =>
      Provider.of<LocalizationProvider>(this, listen: false);

  /// Returns the localization of the app.
  AppLocalizations get localizations => AppLocalizations.of(this)!;

  /// Returns the theme provider of the app.
  ThemeProvider get themeProvider =>
      Provider.of<ThemeProvider>(this, listen: false);

  /// Returns the current color scheme of the app.
  ColorScheme get colorScheme => themeProvider.currentTheme.colorScheme;

  TextTheme get textTheme => themeProvider.currentTheme.textTheme;
}
