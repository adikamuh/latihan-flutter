import 'package:latihan1/core/models/app_base_response.dart';
import 'package:latihan1/features/auth/domain/entities/tenant_entity.dart';

class TenantResponse extends AppBaseResponse<TenantEntity> {
  TenantResponse({
    required super.success,
    required super.message,
    required super.data,
  });

  factory TenantResponse.fromJson(Map<String, dynamic> json) {
    return TenantResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'] != null
          ? TenantEntity.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
