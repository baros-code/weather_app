// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSessionModel _$UserSessionModelFromJson(Map<String, dynamic> json) =>
    UserSessionModel(
      selectedTheme: json['selectedTheme'] as String?,
      selectedLanguage: json['selectedLanguage'] as String?,
      selectedMeasurementSystem: json['selectedMeasurementSystem'] as String?,
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserSessionModelToJson(UserSessionModel instance) =>
    <String, dynamic>{
      'selectedTheme': instance.selectedTheme,
      'selectedLanguage': instance.selectedLanguage,
      'selectedMeasurementSystem': instance.selectedMeasurementSystem,
      'location': instance.location,
    };
