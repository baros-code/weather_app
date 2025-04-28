import 'dart:async';

import '../../../../../core/utils/result.dart';
import '../../../../../core/utils/use_case.dart';
import '../../../weather/domain/entities/current_weather.dart';
import '../entities/user_session.dart';
import '../repositories/auth_repository.dart';

class UpdateUserSession extends UseCase<UserSessionParams, Object, void> {
  UpdateUserSession(this._repository, super.logger);

  final AuthRepository _repository;

  @override
  Future<Result> execute({UserSessionParams? params}) {
    return _repository.updateUserSession(
      date: params?.date,
      currentWeather: params?.currentWeather,
      measurementSystem: params?.selectedMeasurementSystem,
    );
  }
}

class UserSessionParams {
  UserSessionParams({
    required this.date,
    this.currentWeather,
    this.selectedMeasurementSystem,
  });

  final DateTime date;
  final CurrentWeather? currentWeather;
  final MeasurementSystem? selectedMeasurementSystem;
}
