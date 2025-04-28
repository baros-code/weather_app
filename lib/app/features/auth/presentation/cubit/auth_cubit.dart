import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../weather/domain/entities/current_weather.dart';
import '../../domain/entities/user_session.dart';
import '../../domain/usecases/get_user_session.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._getUserSession,
  ) : super(AuthInitial());

  final GetUserSession _getUserSession;

  UserSession? userSession;

  CurrentWeather? get currentWeatherCache => userSession?.currentWeather;

  Future<void> getUserSession() async {
    emit(UserSessionLoading());
    final result = await _getUserSession();
    if (result.isSuccessful) {
      userSession = result.value;
      emit(UserSessionLoaded(result.value!));
      return;
    }
    emit(UserSessionError(result.error!.message));
  }
}
