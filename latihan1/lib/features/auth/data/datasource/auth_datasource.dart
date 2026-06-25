import 'package:latihan1/features/auth/data/models/login_payload.dart';
import 'package:latihan1/features/auth/data/models/login_response.dart';

abstract class AuthDatasource {
  Future<LoginResponse> login(LoginPayload payload);
}
