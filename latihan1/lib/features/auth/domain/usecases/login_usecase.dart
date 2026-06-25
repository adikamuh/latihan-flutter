import 'package:latihan1/features/auth/data/models/login_payload.dart';
import 'package:latihan1/features/auth/domain/entities/login_entity.dart';
import 'package:latihan1/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;
  LoginUsecase(this.repository);

  Future<LoginEntity?> call(LoginPayload payload) async {
    return await repository.login(payload);
  }
}
