class LoginPayload {
  final String code;
  final String login;
  final String password;

  LoginPayload({
    required this.code,
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'code': code,
    'login': login,
    'password': password,
  };
}
