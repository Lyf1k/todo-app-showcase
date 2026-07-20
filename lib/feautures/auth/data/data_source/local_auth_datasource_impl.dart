import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:partfolio_app/core/service/auth_service.dart';
import 'package:partfolio_app/feautures/auth/data/model/user_model.dart';
import 'package:partfolio_app/feautures/auth/domain/datasource/local_auth_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthDatasourceImpl implements LocalAuthDataSource {
  final AuthService authService;
  final SharedPreferencesAsync sharedPreferences;

  LocalAuthDatasourceImpl({
    required this.authService,
    required this.sharedPreferences,
  });

  static const String _usersKeys = 'auth_users';
  static const String _activeUserId = 'active_user_id';

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = await sharedPreferences.getInt(_activeUserId);
      if (user == null) return null;
      final userRaw = await sharedPreferences.getStringList(_usersKeys) ?? [];
      for (final userStr in userRaw) {
        final userJson = jsonDecode(userStr);
        if (userJson['login'] == user) {
          return UserModel.fromJson(userJson);
        }
      }
      return null;
    } catch (e) {
      print("Exception getting user: $e");
      throw Exception(
        "Something went wrong during getCurrentUser data source process",
      );
    }
  }

  @override
  Future<void> logOut() async {
    await sharedPreferences.remove(_activeUserId);
    await authService.logOut();
  }

  @override
  Future<UserModel?> login({
    required String login,
    required String password,
  }) async {
    try {
      final List<String> userRaw =
          await sharedPreferences.getStringList(_usersKeys) ?? [];

      for (final userStr in userRaw) {
        final jsonUser = json.decode(userStr);
        if (jsonUser['login'] == login && jsonUser['password'] == password) {
          final userId = jsonUser['id'];
          await sharedPreferences.setInt(_activeUserId, userId);
          await authService.setLoggedIn(userId);
          return UserModel.fromJson(jsonUser);
        } else {
          null;
        }
      }
      return null;
    } catch (e) {
      throw Exception("Something went wrong during login data source");
    }
  }

  @override
  Future<UserModel?> register({
    required String name,
    required String login,
    required String password,
  }) async {
    try {
      final List<String> userRaw =
          await sharedPreferences.getStringList(_usersKeys) ?? [];

      final newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch,
        name: name,
        login: login,
        password: password,
        token: 'token: ${DateTime.now()}',
      );

      userRaw.add(json.encode(newUser.toJson()));

      await sharedPreferences.setStringList(_usersKeys, userRaw);
      await sharedPreferences.setInt(_activeUserId, newUser.id);
      print("Saved users: $userRaw");
      print("Input login: $login");
      print("Input password: $password");
      await authService.setLoggedIn(newUser.id);
      return newUser;
    } catch (e) {
      throw Exception(
        "Something went wrong during registration. We'll fix later",
      );
    }
  }
}
