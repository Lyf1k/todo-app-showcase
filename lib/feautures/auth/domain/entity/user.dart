class User {
  final int id;
  final String name;
  final String login;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.login,
    required this.token,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "User('$id', '$name', '$login', '$token')";
  }
}
