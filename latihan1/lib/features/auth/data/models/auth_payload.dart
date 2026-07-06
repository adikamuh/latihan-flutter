class AuthPayload {
  final String code;
  final String login;
  final String accessToken;
  final String deviceId;
  final String deviceInfo;

  AuthPayload({
    required this.code,
    required this.login,
    required this.accessToken,
    required this.deviceId,
    required this.deviceInfo,
  });

  Map<String, dynamic> toJson() => {
    'code': code,
    'login': login,
    'access_token': accessToken,
    'device_uuid': deviceId,
    'device_info': deviceInfo,
  };
}
