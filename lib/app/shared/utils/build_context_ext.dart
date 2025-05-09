import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'localization_provider.dart';

extension BuildContextExt on BuildContext {
  /// Returns the localization provider of the app.
  LocalizationProvider get localizationProvider =>
      Provider.of<LocalizationProvider>(this, listen: false);

  /// Returns the localization of the app.
  AppLocalizations get localizations => AppLocalizations.of(this)!;

  TextTheme get textTheme => Theme.of(this).textTheme;
}
