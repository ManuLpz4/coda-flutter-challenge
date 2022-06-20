import 'user.dart';

abstract class IUserRepository {
  Future<User> signUp(String email, String password);
  Future<User> signIn(String email, String password);
  Future<User?> getUser();
  Future<void> signOut();
}
