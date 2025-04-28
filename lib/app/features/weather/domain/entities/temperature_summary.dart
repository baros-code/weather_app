import 'package:equatable/equatable.dart';

class TemperatureSummary extends Equatable {
  const TemperatureSummary({
    required this.day,
    required this.min,
    required this.max,
    required this.eve,
    required this.morn,
    required this.night,
  });

  final double day;
  final double min;
  final double max;
  final double eve;
  final double morn;
  final double night;

  static TemperatureSummary initial() {
    return const TemperatureSummary(
      day: 0,
      min: 0,
      max: 0,
      eve: 0,
      morn: 0,
      night: 0,
    );
  }

  @override
  List<Object> get props => [day, min, max, eve, morn, night];
}
