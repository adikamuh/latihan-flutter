import 'package:latihan1/features/auth/data/models/auth_entity_isar.dart';
import 'package:latihan1/features/auth/data/models/tenant_entity_isar.dart';

abstract class AuthLocalDatasource {
  Future<TenantEntityIsar?> getTenant();
  Future<void> saveTenant(TenantEntityIsar company);
  Future<AuthEntityIsar?> checkAuth();
  Future<void> saveAuth(AuthEntityIsar auth);
  Future<void> clearAuth();
  Future<void> clearAll();
}
