import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../core/utils/constants.dart';
import '../../domain/user/i_user_repository.dart';
import '../../domain/user/user.dart';

class UserRepository implements IUserRepository {
  @override
  Future<User> signUp(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/mia-auth/register'),
        body: {
          'email': email,
          'password': password,
        },
      );
      final json = jsonDecode(response.body);

      if (response.statusCode != 200 || json['success'] == false) {
        throw Exception('Failed to register user');
      }

      final user = User.fromJson(json['response']);

      return user;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<User> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/mia-auth/login'),
        body: {
          'email': email,
          'password': password,
        },
      );
      final json = jsonDecode(response.body);

      if (response.statusCode != 200 || json['success'] == false) {
        throw Exception('Failed to register user');
      }

      final user = User.fromJson(json['response']);
      final userBox = Hive.box('user');
      userBox.put('access_token', json['response']['access_token']);

      return user;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    final userBox = Hive.box('user');
    userBox.delete('access_token');
  }

  @override
  Future<User?> getUser() async {
    // I decided to mock this method because we don't have an endpoint to
    // retrieve the real user object.
    final box = Hive.box('user');

    await Future.delayed(const Duration(seconds: 1));

    if (box.get('access_token') == null) return null;

    return User(
      id: 1,
      firstName: 'empty',
      lastName: '',
      email: 'test@coda.com',
      profilePictureUrl: '',
      caption: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
