// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coord_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoordModel _$CoordModelFromJson(Map<String, dynamic> json) => CoordModel(
      lon: (json['lon'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoordModelToJson(CoordModel instance) =>
    <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };
