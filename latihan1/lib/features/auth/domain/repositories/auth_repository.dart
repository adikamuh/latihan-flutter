import 'package:latihan1/features/auth/data/models/login_payload.dart';
import 'package:latihan1/features/auth/domain/entities/login_entity.dart';

abstract class AuthRepository {
  Future<LoginEntity?> login(LoginPayload payload);
  Future<void> logout();
}
