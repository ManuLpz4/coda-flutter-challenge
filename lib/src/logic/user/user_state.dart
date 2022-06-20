import '../../domain/user/user.dart';
import '../core/state.dart';

abstract class UserState {
  const UserState();
}

class InitialUserState extends UserState implements Initial {
  const InitialUserState();
}

class LoadingUserState extends UserState implements Loading {
  const LoadingUserState();
}

class DataUserState extends UserState implements Data {
  final User user;

  const DataUserState(this.user);
}

class ErrorUserState extends UserState implements Error {
  final String? message;

  const ErrorUserState([this.message]);
}
