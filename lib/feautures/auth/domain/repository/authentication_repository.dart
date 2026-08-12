import 'dart:async';

import 'package:partfolio_app/feautures/auth/domain/entity/user.dart';

abstract interface class AuthenticationRepository {
  Stream<User?> get userStream;

  Future<void> register({
    required String login,
    required String name,
    required String password,
  });

  Future<void> login({required String login, required String password});

  Future<void> logout();

  Future<User?> getCurrentUser();

  Future<void> closeUserStream();
}
