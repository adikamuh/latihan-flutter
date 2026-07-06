import 'package:latihan1/core/services/dio_client.dart';
import 'package:latihan1/core/services/device_info_service.dart';
import 'package:latihan1/core/services/secured_storage_service.dart';
import 'package:latihan1/features/auth/data/datasource/auth_datasource.dart';
import 'package:latihan1/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:latihan1/features/auth/data/models/auth_payload.dart';
import 'package:latihan1/features/auth/data/models/login_payload.dart';
import 'package:latihan1/features/auth/data/models/tenant_payload.dart';
import 'package:latihan1/features/auth/domain/entities/auth_entity.dart';
import 'package:latihan1/features/auth/domain/entities/login_entity.dart';
import 'package:latihan1/features/auth/domain/entities/tenant_entity.dart';
import 'package:latihan1/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;
  final AuthLocalDatasource _localDatasource;
  AuthRepositoryImpl(this._datasource, this._localDatasource);

  @override
  Future<TenantEntity?> code(TenantPayload payload) async {
    final result = await _datasource.code(payload);
    return result.data;
  }

  @override
  Future<LoginEntity?> login(LoginPayload payload) async {
    final result = await _datasource.login(payload);
    DioClient.instance.setToken(result.data?.accessToken ?? '');
    return result.data;
  }

  @override
  Future<void> logout() async {
    await _localDatasource.clearAuth();
    await _localDatasource.clearAll();
    await SecuredStorageService.deleteAll();
    DioClient.instance.clearToken();
  }

  @override
  Future<TenantEntity?> getTenant(String? code) async {
    final localTenant = await _localDatasource.getTenant();

    if (localTenant != null) {
      return localTenant;
    }

    if (code == null || code.isEmpty) {
      return null;
    }

    final payload = TenantPayload(code: code);
    final result = await _datasource.code(payload);

    if (result.data != null) {
      await _localDatasource.saveTenant(result.data!.toIsar());

      return result.data;
    }

    return null;
  }

  @override
  Future<void> saveTenant(TenantEntity tenant) async {
    await _localDatasource.saveTenant(tenant.toIsar());
  }

  @override
  Future<AuthEntity?> checkAuth() async {
    final localAuth = await _localDatasource.checkAuth();

    if (localAuth != null) {
      if (localAuth.expiredAt != null &&
          localAuth.expiredAt!.isBefore(DateTime.now())) {
        await _localDatasource.clearAuth();
        return null;
      }
      final deviceInfo = await DeviceInfoService().getDeviceInfo();
      final payload = AuthPayload(
        code: localAuth.code ?? '',
        login: localAuth.login ?? '',
        accessToken: localAuth.accessToken ?? '',
        deviceId: deviceInfo['deviceId'] as String? ?? '',
        deviceInfo: deviceInfo['platform'] as String? ?? '',
      );
      final result = await _datasource.info(payload);

      if (result.data != null) {
        await _localDatasource.saveAuth(result.data!.toIsar());
        return result.data;
      } else {
        await _localDatasource.clearAuth();
        return null;
      }
    }
    return null;
  }

  Future<void> saveAuth(AuthEntity auth) async {
    await _localDatasource.saveAuth(auth.toIsar());
  }
}
