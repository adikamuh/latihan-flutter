import 'package:latihan1/features/auth/domain/entities/tenant_entity.dart';
import 'package:latihan1/features/auth/domain/repositories/auth_repository.dart';

class SaveTenant {
  final AuthRepository repository;

  SaveTenant(this.repository);

  Future<void> call(TenantEntity tenant) async {
    await repository.saveTenant(tenant);
  }
}
