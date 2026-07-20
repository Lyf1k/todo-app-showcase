import 'package:partfolio_app/feautures/auth/data/model/user_model.dart';
import 'package:partfolio_app/feautures/auth/domain/entity/user.dart';

final class UserMapper {
  User toUser(UserModel? user) {
    return User(
      id: user?.id ?? 0,
      name: user?.name ?? "test",
      login: user?.login ?? "login",
      token: user?.token ?? "password",
    );
  }
}
