import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/datasource/local_auth_data_source.dart';
import '../model/user_model.dart';

class LocalAuthDatasourceImpl implements LocalAuthDataSource {
  final SharedPreferencesAsync sharedPreferences;

  LocalAuthDatasourceImpl({required this.sharedPreferences});

  static const String _usersKeys = 'auth_users';
  static const String _activeUserId = 'active_user_id';

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final activeUser = await sharedPreferences.getInt(_activeUserId);
      if (activeUser == null) return null;
      print("User from LocalStorage -- $activeUser");
      final userRaw = await sharedPreferences.getStringList(_usersKeys) ?? [];
      for (final userStr in userRaw) {
        final userJson = jsonDecode(userStr);
        if (userJson['id'] == activeUser) {
          return UserModel.fromJson(userJson);
        }
      }
    } catch (e) {
      print("Exception getting user: $e");
      throw Exception(
        "Something went wrong during getCurrentUser data source process",
      );
    }
    return null;
  }

  @override
  Future<void> logOut() async {
    await sharedPreferences.remove(_activeUserId);
    final user = await sharedPreferences.getInt(_activeUserId);
    print("user: $user");
    // await authService.logOut();
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
      return newUser;
    } catch (e) {
      throw Exception(
        "Something went wrong during registration. We'll fix later",
      );
    }
  }
}
