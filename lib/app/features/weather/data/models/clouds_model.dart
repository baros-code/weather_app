import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/clouds.dart';


part 'clouds_model.g.dart';

@JsonSerializable()
class CloudsModel {
  CloudsModel({
    required this.all,
  });

  final int? all;

  factory CloudsModel.fromJson(Map<String, dynamic> json) =>
      _$CloudsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsModelToJson(this);

  factory CloudsModel.fromEntity(Clouds entity) {
    return CloudsModel(
      all: entity.all,
    );
  }

  Clouds toEntity() {
    return Clouds(
      all: all,
    );
  }
}
