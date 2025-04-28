import 'dart:async';

import '../../../../../core/utils/result.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/user_session.dart';
import '../repositories/auth_repository.dart';

class GetUserSession extends UseCase<void, UserSession, void> {
  GetUserSession(this._repository, super.logger);

  final AuthRepository _repository;

  @override
  Future<Result<UserSession, Failure>> execute({void params}) {
    return _repository.getUserSession();
  }
}
