import '../../../../../core/utils/result.dart';
import '../../../weather/domain/entities/current_weather.dart';
import '../entities/user_session.dart';

abstract class AuthRepository {
  Future<Result<UserSession, Failure>> getUserSession();

  Future<Result> updateUserSession({
    required DateTime? date,
    CurrentWeather? currentWeather,
    MeasurementSystem? measurementSystem,
  });
}
