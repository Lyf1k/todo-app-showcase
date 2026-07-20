import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../domain/datasource/local_auth_data_source.dart';
import '../../domain/entity/user.dart';
import '../../domain/repository/authentication_repository.dart';
import '../mapper/user_mapper.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final LocalAuthDataSource dataSource;
  final UserMapper mapper;
  late BehaviorSubject<User?> _userStream = BehaviorSubject<User?>();

  AuthenticationRepositoryImpl({required this.dataSource, required this.mapper})
    : _userStream = BehaviorSubject<User?>.seeded(null) {
    print("Init Authentication repository");
    getCurrentUser();
  }

  @override
  BehaviorSubject<User?> get userStream => _userStream;

  @override
  Future<void> login({required String login, required String password}) async {
    try {
      final user = await dataSource.login(login: login, password: password);
      if (user != null) {
        _userStream.add(mapper.toUser(user));
        print("Loggin: ${mapper.toUser(user)}");
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dataSource.logOut();
      _userStream.add(null);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> register({
    required String login,
    required String name,
    required String password,
  }) async {
    try {
      final user = await dataSource.register(
        login: login,
        password: password,
        name: name,
      );
      print(user.toString());
      if (user != null) {
        _userStream.add(mapper.toUser(user));
      }
    } catch (e) {
      throw Exception("Some error: $e");
    }
  }

  @override
  Future<void> getCurrentUser() async {
    final user = await dataSource.getCurrentUser();
    print("Getting user from dataSource");
    _userStream.add(mapper.toUser(user));
  }

  @override
  Future<void> closeUserStream() async {
    // TODO: implement closeUserStream
    if (_userStream.isClosed == false) null;
    _userStream.close();
  }
}
