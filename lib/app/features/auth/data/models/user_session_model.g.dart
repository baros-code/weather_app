// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSessionModel _$UserSessionModelFromJson(Map<String, dynamic> json) =>
    UserSessionModel(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      currentWeather: json['currentWeather'] == null
          ? null
          : CurrentWeatherModel.fromJson(
              json['currentWeather'] as Map<String, dynamic>),
      selectedMeasurementSystem: json['selectedMeasurementSystem'] as String?,
    );

Map<String, dynamic> _$UserSessionModelToJson(UserSessionModel instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'currentWeather': instance.currentWeather,
      'selectedMeasurementSystem': instance.selectedMeasurementSystem,
    };
