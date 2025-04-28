import '../../../../../core/data/local_storage.dart';
import '../../../../../core/utils/result.dart';
import '../models/user_session_model.dart';

abstract class SessionLocalStorage {
  Future<Result<UserSessionModel, Failure>> getUserSession();

  Future<Result> updateUserSession(UserSessionModel? userSessionModel);
}

class SessionLocalStorageImpl extends LocalStorage<UserSessionModel>
    implements SessionLocalStorage {
  SessionLocalStorageImpl(super.logger);

  @override
  Future<Result<UserSessionModel, Failure>> getUserSession() async {
    final userSession = await getUniqueItem();
    final timeDiff =
        DateTime.now().difference(userSession?.date ?? DateTime.now());
    // Checks the time difference between the current time and cache snapshot.
    // If the difference is big, we have to fetch the data again.
    // It's set to 30 seconds for testing purposes.
    // In production, it could be set to 5 minutes or more.
    if (userSession == null || timeDiff.inSeconds > 30) {
      return Result.failure(
        const Failure(
          message: 'User session found as null in the local storage.',
        ),
      );
    }

    return Result.success(value: userSession);
  }

  @override
  Future<Result> updateUserSession(UserSessionModel? userSessionModel) async {
    await updateUniqueItem(userSessionModel);
    return Result.success();
  }
}
