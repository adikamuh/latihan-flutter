import 'package:latihan1/core/models/app_base_response.dart';
import 'package:latihan1/features/auth/domain/entities/login_entity.dart';

class LoginResponse extends AppBaseResponse<LoginEntity> {
  LoginResponse({
    required super.success,
    required super.message,
    required super.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'] != null
          ? LoginEntity.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
