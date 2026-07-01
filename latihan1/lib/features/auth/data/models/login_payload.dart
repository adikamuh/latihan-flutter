class LoginPayload {
  final String code;
  final String login;
  final String password;
  final String deviceUuid;
  final String deviceInfo;

  LoginPayload({
    required this.code,
    required this.login,
    required this.password,
    required this.deviceUuid,
    required this.deviceInfo,
  });

  Map<String, dynamic> toJson() => {
    'code': code,
    'login': login,
    'password': password,
    'device_uuid': deviceUuid,
    'device_info': deviceInfo,
  };
}
