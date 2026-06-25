import 'package:latihan1/core/constants/api_const.dart';
import 'package:latihan1/core/services/dio_client.dart';
import 'package:latihan1/features/auth/data/datasource/auth_datasource.dart';
import 'package:latihan1/features/auth/data/models/login_payload.dart';
import 'package:latihan1/features/auth/data/models/login_response.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final DioClient _dioClient;
  AuthDatasourceImpl(this._dioClient);

  @override
  Future<LoginResponse> login(LoginPayload payload) async {
    final response = await _dioClient.post(
      ApiConst.login,
      data: payload.toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }
}
