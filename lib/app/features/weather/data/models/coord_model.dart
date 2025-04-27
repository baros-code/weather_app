import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/coord.dart';


part 'coord_model.g.dart';

@JsonSerializable()
class CoordModel {
  const CoordModel({
    required this.lon,
    required this.lat,
  });

  final double? lon;
  final double? lat;

  factory CoordModel.fromJson(Map<String, dynamic> json) =>
      _$CoordModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordModelToJson(this);

  factory CoordModel.fromEntity(Coord entity) {
    return CoordModel(
      lon: entity.lon,
      lat: entity.lat,
    );
  }

  Coord toEntity() {
    return Coord(
      lon: lon ?? 0.0,
      lat: lat ?? 0.0,
    );
  }
}
