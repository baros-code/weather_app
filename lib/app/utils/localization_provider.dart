import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {
  late Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (locale != _locale) {
      _locale = locale;
      notifyListeners();
    }
  }
}
