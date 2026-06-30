import 'package:latihan1/features/auth/data/models/tenant_payload.dart';
import 'package:latihan1/features/auth/domain/entities/tenant_entity.dart';
import 'package:latihan1/features/auth/domain/repositories/auth_repository.dart';

class TenantUsecase {
  final AuthRepository repository;
  TenantUsecase(this.repository);

  Future<TenantEntity?> call(TenantPayload payload) async {
    return await repository.code(payload);
  }
}
