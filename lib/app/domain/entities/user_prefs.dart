import 'package:equatable/equatable.dart';

class UserPrefs extends Equatable {
  const UserPrefs({
    required this.selectedTheme,
    required this.selectedLanguage,
    required this.selectedMeasurementSystem,
    required this.location,
  });

  final ThemeMode selectedTheme;
  final Language selectedLanguage;
  final MeasurementSystem selectedMeasurementSystem;
  final Location location;

  @override
  List<Object?> get props =>
      [selectedTheme, selectedLanguage, selectedMeasurementSystem, location];
}

class Location extends Equatable {
  const Location({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
}

enum ThemeMode {
  light,
  dark,
}

enum Language {
  english,
  spanish,
}

enum MeasurementSystem {
  metric,
  imperial,
}
