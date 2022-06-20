import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/user/i_user_repository.dart';
import 'user_state.dart';

class UserController extends StateNotifier<UserState> {
  final IUserRepository userRepository;

  UserController({
    required this.userRepository,
  }) : super(const InitialUserState());

  Future<void> getUser() async {
    state = const LoadingUserState();

    try {
      final user = await userRepository.getUser();

      if (user != null) {
        state = DataUserState(user);
      } else {
        state = const InitialUserState();
      }
    } catch (_) {
      state = const ErrorUserState();
    }
  }

  Future<void> signUp(String email, String password) async {
    state = const LoadingUserState();

    try {
      final user = await userRepository.signUp(email, password);
      state = DataUserState(user);
    } catch (_) {
      state = const ErrorUserState();
    }
  }

  Future<void> signIn(String email, String password) async {
    state = const LoadingUserState();

    try {
      final user = await userRepository.signIn(email, password);
      state = DataUserState(user);
    } catch (_) {
      state = const ErrorUserState();
    }
  }

  void signOut() {
    try {
      userRepository.signOut();
    } finally {
      state = const InitialUserState();
    }
  }
}
