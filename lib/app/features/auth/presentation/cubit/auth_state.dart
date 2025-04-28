part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class UserSessionLoading extends AuthState {}

class UserSessionLoaded extends AuthState {
  const UserSessionLoaded(this.userSession);

  final UserSession userSession;

  @override
  List<Object> get props => [userSession];
}

class UserSessionError extends AuthState {
  const UserSessionError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
