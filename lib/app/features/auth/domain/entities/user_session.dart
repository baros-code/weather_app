import 'package:equatable/equatable.dart';

import '../../../../shared/domain/entities/location.dart';

// TODO(Baran): Add current weather for cache.
class UserSession extends Equatable {
  const UserSession({
    required this.selectedTheme,
    required this.selectedLanguage,
    required this.selectedMeasurementSystem,
    required this.location,
  });

  final CustomThemeMode selectedTheme;
  final Language selectedLanguage;
  final MeasurementSystem selectedMeasurementSystem;
  final Location location;

  @override
  List<Object?> get props =>
      [selectedTheme, selectedLanguage, selectedMeasurementSystem, location];
}

enum CustomThemeMode {
  light('light'),
  dark('dark');

  const CustomThemeMode(this.value);

  final String value;

  static CustomThemeMode fromString(String? value) {
    return CustomThemeMode.values.firstWhere(
      (e) => e.value == value,
      orElse: () => CustomThemeMode.light,
    );
  }
}

enum Language {
  english('en'),
  spanish('es');

  const Language(this.value);
  final String value;

  static Language fromString(String? value) {
    return Language.values.firstWhere(
      (e) => e.value == value,
      orElse: () => Language.english,
    );
  }
}

enum MeasurementSystem {
  metric('metric'),
  imperial('imperial');

  const MeasurementSystem(this.value);
  final String value;

  static MeasurementSystem fromString(String? value) {
    return MeasurementSystem.values.firstWhere(
      (e) => e.value == value,
      orElse: () => MeasurementSystem.metric,
    );
  }
}
