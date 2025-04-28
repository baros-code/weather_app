import 'package:json_annotation/json_annotation.dart';

import '../../../../shared/data/models/location_model.dart';
import '../../../weather/data/models/current_weather_model.dart';
import '../../domain/entities/user_session.dart';

part 'user_session_model.g.dart';

@JsonSerializable()
class UserSessionModel {
  const UserSessionModel({
    required this.date,
    required this.currentWeather,
    required this.selectedMeasurementSystem,
  });

  final DateTime? date;
  final CurrentWeatherModel? currentWeather;
  final String? selectedMeasurementSystem;

  factory UserSessionModel.fromJson(Map<String, dynamic> json) =>
      _$UserSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserSessionModelToJson(this);

  factory UserSessionModel.fromEntity(UserSession entity) {
    return UserSessionModel(
      date: entity.date,
      currentWeather: entity.currentWeather != null
          ? CurrentWeatherModel.fromEntity(entity.currentWeather!)
          : null,
      selectedMeasurementSystem: entity.selectedMeasurementSystem?.value,
    );
  }

  UserSession toEntity() {
    return UserSession(
      date: date ?? DateTime.now(),
      currentWeather: currentWeather?.toEntity(),
      selectedMeasurementSystem:
          MeasurementSystem.fromString(selectedMeasurementSystem),
    );
  }
}
