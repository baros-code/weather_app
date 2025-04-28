import 'package:equatable/equatable.dart';

import '../../../../app_config.dart';

class Weather extends Equatable {
  const Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int id;
  final String main;
  final String description;
  final String icon;

  static Weather initial() {
    return const Weather(
      id: 0,
      main: AppConfig.defaultString,
      description: AppConfig.defaultString,
      icon: AppConfig.defaultString,
    );
  }

  @override
  List<Object?> get props => [id, main, description, icon];
}
