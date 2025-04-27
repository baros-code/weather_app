import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/location.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  const LocationModel({
    required this.latitude,
    required this.longitude,
  });

  final double? latitude;
  final double? longitude;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  factory LocationModel.fromEntity(Location entity) {
    return LocationModel(
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }

  Location toEntity() {
    return Location(
      latitude: latitude ?? 0.0,
      longitude: longitude ?? 0.0,
    );
  }
}
