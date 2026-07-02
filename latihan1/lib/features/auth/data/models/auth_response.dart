import 'package:latihan1/core/models/app_base_response.dart';
import 'package:latihan1/features/auth/domain/entities/auth_entity.dart';

class AuthResponse extends AppBaseResponse<AuthEntity> {
  AuthResponse({
    required super.success,
    required super.message,
    required super.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'] != null
          ? AuthEntity.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
