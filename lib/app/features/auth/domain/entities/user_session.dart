import 'package:equatable/equatable.dart';

import '../../../weather/domain/entities/current_weather.dart';

class UserSession extends Equatable {
  const UserSession({
    required this.date,
    this.currentWeather,
    this.selectedMeasurementSystem,
  });

  final DateTime date;
  final CurrentWeather? currentWeather;
  final MeasurementSystem? selectedMeasurementSystem;

  UserSession copyWith({
    DateTime? date,
    CurrentWeather? currentWeather,
    MeasurementSystem? selectedMeasurementSystem,
  }) {
    return UserSession(
      date: date ?? this.date,
      currentWeather: currentWeather ?? this.currentWeather,
      selectedMeasurementSystem:
          selectedMeasurementSystem ?? this.selectedMeasurementSystem,
    );
  }

  @override
  List<Object?> get props => [
        date,
        currentWeather,
        selectedMeasurementSystem,
      ];
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
