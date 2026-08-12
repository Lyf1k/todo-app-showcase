import 'package:flutter/material.dart';

import '../../domain/entity/user.dart';
import '../../domain/repository/authentication_repository.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthController extends ChangeNotifier {
  final AuthenticationRepository authRepository;
  AuthController({required this.authRepository}) {
    init();
  }

  @override
  String toString() => 'AuthController';

  User? _user;
  User? get user => _user;

  AuthStatus _status = AuthStatus.unknown;
  AuthStatus get status => _status;

  bool get isLoggedIn => _status == AuthStatus.authenticated;
  bool get isLoading => _status == AuthStatus.unknown;

  Future<void> init() async {
    print("Init AuthController => refreshing user");
    print("Notifying listeners, instance = ${identityHashCode(this)}");
    await refreshUser();
  }

  Future<void> refreshUser() async {
    try {
      // print("Notifying listeners, instance = ${identityHashCode(this)}");
      final fetchUser = await authRepository.getCurrentUser();
      _user = fetchUser;
      _status = _user != null
          ? AuthStatus.authenticated
          : AuthStatus.unauthenticated;
      print("User refreshed: user => $user, status => $status");
    } catch (e) {
      print("$e");
      _user = null;
      _status = AuthStatus.unauthenticated;
    } finally {
      print("Notifiying authController listeners");
      notifyListeners();
    }
  }

  Future<void> login({required String login, required String password}) async {
    try {
      await authRepository.login(login: login, password: password);
      final user = await authRepository.getCurrentUser();
      if (user != null) {
        _user = user;
        _status = AuthStatus.authenticated;
      }
    } on Object catch (error, stackTrace) {
      _user = null;
      _status = AuthStatus.unauthenticated;
      rethrow; // or Error.throwWithStackTrace(error, stackTrace);
    } finally {
      notifyListeners();
    }
  }

  Future<void> registration({
    required String login,
    required String name,
    required String password,
  }) async {
    try {
      await authRepository.register(
        login: login,
        name: name,
        password: password,
      );
      // final user = await authRepository.getCurrentUser();
      // if (user != null) {
      //   _user = user;
      //   _status = AuthStatus.authenticated;
      // }
    } on Object catch (error, stackTrace) {
      _user = null;
      _status = AuthStatus.unauthenticated;
      rethrow; // or Error.throwWithStackTrace(error, stackTrace);
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
