import 'package:latihan1/core/services/dio_client.dart';
import 'package:latihan1/features/auth/data/datasource/auth_datasource.dart';
import 'package:latihan1/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:latihan1/features/auth/data/models/login_payload.dart';
import 'package:latihan1/features/auth/domain/entities/company_entity.dart';
import 'package:latihan1/features/auth/domain/entities/login_entity.dart';
import 'package:latihan1/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;
  final AuthLocalDatasource _localDatasource;
  AuthRepositoryImpl(this._datasource, this._localDatasource);

  @override
  Future<LoginEntity?> login(LoginPayload payload) async {
    final result = await _datasource.login(payload);
    DioClient.instance.setToken(result.data?.accessToken ?? '');
    return result.data;
  }

  @override
  Future<void> logout() => throw UnimplementedError();

  @override
  Future<CompanyEntity?> getCompanyByCode(String code) async {
    final company = await _localDatasource.getCompanyByCode(code);
    return company;
  }

  @override
  Future<void> saveCompanyToLocalDB(CompanyEntity company) async {
    await _localDatasource.saveCompanyToLocalDB(company.toIsar());
  }
}
