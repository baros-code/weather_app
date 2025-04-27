import 'package:json_annotation/json_annotation.dart';

import '../../../../shared/data/models/location_model.dart';
import '../../../../shared/domain/entities/location.dart';
import '../../domain/entities/user_session.dart';

part 'user_session_model.g.dart';

@JsonSerializable()
class UserSessionModel {
  const UserSessionModel({
    required this.selectedTheme,
    required this.selectedLanguage,
    required this.selectedMeasurementSystem,
    required this.location,
  });

  final String? selectedTheme;
  final String? selectedLanguage;
  final String? selectedMeasurementSystem;
  final LocationModel? location;

  factory UserSessionModel.fromJson(Map<String, dynamic> json) =>
      _$UserSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserSessionModelToJson(this);

  factory UserSessionModel.fromEntity(UserSession entity) {
    return UserSessionModel(
      selectedTheme: entity.selectedTheme.value,
      selectedLanguage: entity.selectedLanguage.value,
      selectedMeasurementSystem: entity.selectedMeasurementSystem.value,
      location: LocationModel.fromEntity(entity.location),
    );
  }

  UserSession toEntity() {
    return UserSession(
      selectedTheme: CustomThemeMode.fromString(selectedTheme),
      selectedLanguage: Language.fromString(selectedLanguage),
      selectedMeasurementSystem:
          MeasurementSystem.fromString(selectedMeasurementSystem),
      location: location?.toEntity() ?? Location.initial(),
    );
  }
}
