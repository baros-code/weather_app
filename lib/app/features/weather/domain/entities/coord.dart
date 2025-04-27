import 'package:equatable/equatable.dart';

class Coord extends Equatable {
  const Coord({
    required this.lon,
    required this.lat,
  });

  final double lon;
  final double lat;

  @override
  List<Object?> get props => [lon, lat];
}
