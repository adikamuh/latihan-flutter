import 'package:isar_community/isar.dart';
import 'package:latihan1/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:latihan1/features/auth/data/models/auth_entity_isar.dart';
import 'package:latihan1/features/auth/data/models/tenant_entity_isar.dart';

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final Isar _isar;
  AuthLocalDatasourceImpl(this._isar);

  @override
  Future<TenantEntityIsar?> getTenant() async {
    final tenant = await _isar.tenantEntityIsars.where().limit(1).findFirst();
    return tenant;
  }

  @override
  Future<void> saveTenant(TenantEntityIsar tenant) async {
    await _isar.writeTxn(() async {
      await _isar.tenantEntityIsars.clear();
      await _isar.tenantEntityIsars.put(tenant);
    });
  }

  @override
  Future<AuthEntityIsar?> checkAuth() async {
    final auth = await _isar.authEntityIsars.where().limit(1).findFirst();
    return auth;
  }

  @override
  Future<void> saveAuth(AuthEntityIsar auth) async {
    await _isar.writeTxn(() async {
      await _isar.authEntityIsars.clear();
      await _isar.authEntityIsars.put(auth);
    });
  }

  @override
  Future<void> clearAuth() async {
    await _isar.writeTxn(() async {
      await _isar.authEntityIsars.clear();
    });
  }
}
