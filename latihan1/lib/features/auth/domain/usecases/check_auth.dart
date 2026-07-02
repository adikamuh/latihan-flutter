import 'package:latihan1/features/auth/domain/entities/auth_entity.dart';
import 'package:latihan1/features/auth/domain/repositories/auth_repository.dart';

class CheckAuth {
  final AuthRepository repository;

  CheckAuth(this.repository);

  Future<AuthEntity?> call() async {
    return await repository.checkAuth();
  }
}
