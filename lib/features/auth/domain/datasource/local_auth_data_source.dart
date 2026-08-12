import '../../data/model/user_model.dart';

abstract class LocalAuthDataSource {
  Future<UserModel?> register({
    required String login,
    required String password,
    required String name,
  });

  Future<UserModel?> login({required String login, required String password});

  Future<void> logOut();

  Future<UserModel?> getCurrentUser();
}
