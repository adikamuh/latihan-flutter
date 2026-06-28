import 'package:latihan1/features/auth/domain/entities/tenant_entity.dart';
import 'package:latihan1/features/auth/domain/repositories/auth_repository.dart';

class GetTenant {
  final AuthRepository repository;

  GetTenant(this.repository);

  Future<TenantEntity?> call(String code) async {
    return await repository.getTenant(code);
  }
}
