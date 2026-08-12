import '../../domain/entity/user.dart';
import '../model/user_model.dart';

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
