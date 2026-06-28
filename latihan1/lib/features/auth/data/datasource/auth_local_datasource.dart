import 'package:latihan1/features/auth/data/models/tenant_entity_isar.dart';

abstract class AuthLocalDatasource {
  Future<TenantEntityIsar?> getTenant(String code);
  Future<void> saveTenant(TenantEntityIsar company);
}
