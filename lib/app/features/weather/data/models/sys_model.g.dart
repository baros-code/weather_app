// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sys_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SysModel _$SysModelFromJson(Map<String, dynamic> json) => SysModel(
      type: (json['type'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      country: json['country'] as String?,
      sunrise: (json['sunrise'] as num?)?.toInt(),
      sunset: (json['sunset'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SysModelToJson(SysModel instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'country': instance.country,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
