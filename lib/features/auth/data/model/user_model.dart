import '../../domain/entity/user.dart';

class UserModel extends User {
  final String password;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  UserModel({
    required super.id,
    required super.name,
    required super.login,
    required super.token,
    required this.password,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "UserModel(id: $id, name: $name, login: $login, token: $token, password: $password)";
  }

  factory UserModel.fromJson(Map<String, dynamic> e) {
    return UserModel(
      id: e['id'],
      name: e['name'] as String,
      login: e['login'] as String,
      token: e['token'] as String,
      password: e['password'] as String,
      createdAt: e['created_at'] as String?,
      updatedAt: e['updated_at'] as String?,
      deletedAt: e['deleted_at'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'login': login,
    'token': token,
    'password': password,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'deleted_at': deletedAt,
  };

  User toUser(UserModel? user) {
    return User(
      id: user?.id ?? 0,
      name: user?.name ?? "test",
      login: user?.login ?? "login",
      token: user?.token ?? "password",
    );
  }
}
