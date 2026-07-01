import 'package:latihan1/core/services/dio_client.dart';
import 'package:latihan1/features/auth/data/datasource/auth_datasource.dart';
import 'package:latihan1/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:latihan1/features/auth/data/models/login_payload.dart';
import 'package:latihan1/features/auth/data/models/tenant_payload.dart';
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
    // DioClient.instance.setToken(result.data?.accessToken ?? '');
    return result.data;
  }

  @override
  Future<LoginEntity?> login(LoginPayload payload) async {
    final result = await _datasource.login(payload);
    DioClient.instance.setToken(result.data?.accessToken ?? '');
    return result.data;
  }

  @override
  Future<void> logout() => throw UnimplementedError();

  @override
  Future<TenantEntity?> getTenant(String? code) async {
    final localTenant = await _localDatasource.getTenant();

    if (localTenant != null) {
      return localTenant;
    } else if (code == null || code.isEmpty) {
      throw Exception('Code is required to fetch tenant data');
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
}
