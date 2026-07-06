import 'package:latihan1/features/auth/data/models/auth_entity_isar.dart';

class AuthEntity {
  final String? code;
  final String? login;
  final String? accessToken;
  final DateTime? expiredAt;

  AuthEntity({
    required this.code,
    required this.login,
    required this.accessToken,
    required this.expiredAt,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
      code: json['code'] as String?,
      login: json['login'] as String?,
      accessToken: json['accessToken'] as String?,
      expiredAt: json['expiredAt'] != null
          ? DateTime.parse(json['expiredAt'] as String)
          : null,
    );
  }

  AuthEntityIsar toIsar() {
    return AuthEntityIsar(
      code: code ?? '',
      login: login ?? '',
      accessToken: accessToken ?? '',
      expiredAt: expiredAt,
    );
  }
}
