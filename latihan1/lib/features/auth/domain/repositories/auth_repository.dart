import 'package:latihan1/features/auth/data/models/login_payload.dart';
import 'package:latihan1/features/auth/data/models/tenant_payload.dart';
import 'package:latihan1/features/auth/domain/entities/auth_entity.dart';
import 'package:latihan1/features/auth/domain/entities/login_entity.dart';
import 'package:latihan1/features/auth/domain/entities/tenant_entity.dart';

abstract class AuthRepository {
  Future<TenantEntity?> code(TenantPayload payload);
  Future<LoginEntity?> login(LoginPayload payload);
  Future<void> logout();
  Future<TenantEntity?> getTenant(String? code, bool forceRequest);
  Future<void> saveTenant(TenantEntity tenant);
  Future<AuthEntity?> checkAuth();
}
