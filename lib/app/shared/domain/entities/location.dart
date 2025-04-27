import 'package:equatable/equatable.dart';

class Location extends Equatable {
  const Location({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  static Location initial() {
    return const Location(
      latitude: 0,
      longitude: 0,
    );
  }

  @override
  List<Object?> get props => [latitude, longitude];
}
