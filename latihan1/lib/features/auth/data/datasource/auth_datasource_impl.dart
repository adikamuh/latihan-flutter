import 'package:latihan1/core/constants/api_const.dart';
import 'package:latihan1/core/services/dio_client.dart';
import 'package:latihan1/features/auth/data/datasource/auth_datasource.dart';
import 'package:latihan1/features/auth/data/models/auth_payload.dart';
import 'package:latihan1/features/auth/data/models/auth_response.dart';
import 'package:latihan1/features/auth/data/models/login_payload.dart';
import 'package:latihan1/features/auth/data/models/login_response.dart';
import 'package:latihan1/features/auth/data/models/tenant_payload.dart';
import 'package:latihan1/features/auth/data/models/tenant_response.dart';

class AuthDatasourceImpl implements AuthDatasource {
  late final DioClient _dioClient;
  AuthDatasourceImpl(this._dioClient);

  @override
  Future<TenantResponse> code(TenantPayload payload) async {
    final response = await _dioClient.post(
      ApiConst.tenant,
      data: payload.toJson(),
    );
    return TenantResponse.fromJson(response.data);
  }

  @override
  Future<LoginResponse> login(LoginPayload payload) async {
    final response = await _dioClient.post(
      ApiConst.login,
      data: payload.toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }

  @override
  Future<AuthResponse> info(AuthPayload payload) async {
    final response = await _dioClient.post(
      ApiConst.info,
      data: payload.toJson(),
    );
    return AuthResponse.fromJson(response.data);
  }
}
