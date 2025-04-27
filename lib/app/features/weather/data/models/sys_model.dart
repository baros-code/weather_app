import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/sys.dart';

part 'sys_model.g.dart';

@JsonSerializable()
class SysModel {
  const SysModel({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  factory SysModel.fromJson(Map<String, dynamic> json) =>
      _$SysModelFromJson(json);

  Map<String, dynamic> toJson() => _$SysModelToJson(this);

  factory SysModel.fromEntity(Sys entity) {
    return SysModel(
      type: entity.type,
      id: entity.id,
      country: entity.country,
      sunrise: entity.sunrise,
      sunset: entity.sunset,
    );
  }

  Sys toEntity() {
    return Sys(
      type: type,
      id: id,
      country: country,
      sunrise: sunrise,
      sunset: sunset,
    );
  }
}
