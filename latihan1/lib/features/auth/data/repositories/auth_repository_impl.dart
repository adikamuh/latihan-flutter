import 'package:latihan1/core/services/dio_client.dart';
import 'package:latihan1/features/auth/data/datasource/auth_datasource.dart';
import 'package:latihan1/features/auth/data/models/login_payload.dart';
import 'package:latihan1/features/auth/data/models/tenant_payload.dart';
import 'package:latihan1/features/auth/domain/entities/login_entity.dart';
import 'package:latihan1/features/auth/domain/entities/tenant_entity.dart';
import 'package:latihan1/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;
  AuthRepositoryImpl(this._datasource);

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
}
