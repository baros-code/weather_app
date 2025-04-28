// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temperature_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemperatureSummaryModel _$TemperatureSummaryModelFromJson(
        Map<String, dynamic> json) =>
    TemperatureSummaryModel(
      day: (json['day'] as num?)?.toDouble(),
      min: (json['min'] as num?)?.toDouble(),
      max: (json['max'] as num?)?.toDouble(),
      eve: (json['eve'] as num?)?.toDouble(),
      morn: (json['morn'] as num?)?.toDouble(),
      night: (json['night'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TemperatureSummaryModelToJson(
        TemperatureSummaryModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'min': instance.min,
      'max': instance.max,
      'eve': instance.eve,
      'morn': instance.morn,
      'night': instance.night,
    };
