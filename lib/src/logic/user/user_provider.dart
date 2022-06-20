import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/user/user_repository.dart';
import '../../domain/user/i_user_repository.dart';
import 'user_controller.dart';
import 'user_state.dart';

final userRepositoryProvider = Provider<IUserRepository>((_) {
  return UserRepository();
});

final userControllerProvider =
    StateNotifierProvider<UserController, UserState>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);

  return UserController(userRepository: userRepository)..getUser();
});
