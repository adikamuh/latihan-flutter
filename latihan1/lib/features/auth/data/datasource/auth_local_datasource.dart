import 'package:latihan1/features/auth/data/models/tenant_entity_isar.dart';

abstract class AuthLocalDatasource {
  Future<TenantEntityIsar?> getTenant();
  Future<void> saveTenant(TenantEntityIsar company);
}
