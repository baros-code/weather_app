import 'package:equatable/equatable.dart';

class Wind extends Equatable {
  const Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  final double? speed;
  final int? deg;
  final double? gust;

  @override
  List<Object?> get props => [speed, deg, gust];
}
