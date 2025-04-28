import '../../../../../core/utils/result.dart';
import '../../../weather/domain/entities/current_weather.dart';
import '../../domain/entities/user_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_session_model.dart';
import '../services/session_local_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._sessionLocalStorage);

  final SessionLocalStorage _sessionLocalStorage;

  UserSession? _userSession;

  @override
  Future<Result<UserSession, Failure>> getUserSession() async {
    try {
      final result = await _sessionLocalStorage.getUserSession();
      if (result.isSuccessful) {
        _userSession = result.value!.toEntity();
        return Result.success(value: result.value!.toEntity());
      }
      return Result.failure(
        const Failure(message: 'Error occurred while getting user session.'),
      );
    } catch (e) {
      return Result.failure(
        const Failure(message: 'Error occurred while getting user session.'),
      );
    }
  }

  @override
  Future<Result> updateUserSession({
    required DateTime? date,
    CurrentWeather? currentWeather,
    MeasurementSystem? measurementSystem,
  }) async {
    final newSession = _userSession != null
        ? _userSession!.copyWith(
            currentWeather: currentWeather,
            selectedMeasurementSystem: measurementSystem,
          )
        : UserSession(
            date: date ?? DateTime.now(),
            currentWeather: currentWeather,
            selectedMeasurementSystem: measurementSystem,
          );
    return _sessionLocalStorage
        .updateUserSession(UserSessionModel.fromEntity(newSession));
  }
}
