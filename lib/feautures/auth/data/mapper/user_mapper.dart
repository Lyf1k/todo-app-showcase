import 'package:partfolio_app/feautures/auth/data/model/user_model.dart';
import 'package:partfolio_app/feautures/auth/domain/entity/user.dart';

final class UserMapper {
  User toUser(UserModel user) {
    return User(
      id: user.id,
      name: user.name,
      login: user.login,
      token: user.token,
    );
  }
}
