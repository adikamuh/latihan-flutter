import 'package:isar_community/isar.dart';
import 'package:latihan1/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:latihan1/features/auth/data/models/tenant_entity_isar.dart';

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final Isar _isar;
  AuthLocalDatasourceImpl(this._isar);

  @override
  Future<TenantEntityIsar?> getTenant(String code) async {
    final tenant = await _isar.tenantEntityIsars
        .filter()
        .codeEqualTo(code)
        .findFirst();
    return tenant;
  }

  @override
  Future<void> saveTenant(TenantEntityIsar tenant) async {
    await _isar.writeTxn(() async {
      await _isar.tenantEntityIsars.put(tenant);
    });
  }
}
