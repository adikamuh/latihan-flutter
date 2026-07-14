import 'package:isar_community/isar.dart';
import 'package:latihan1/features/auth/domain/entities/tenant_entity.dart';

part 'tenant_entity_isar.g.dart';

@collection
class TenantEntityIsar extends TenantEntity {
  final Id idIsar;
  TenantEntityIsar({
    this.idIsar = Isar.autoIncrement,
    required super.id,
    required super.name,
    required super.code,
    required super.logo,
    required super.address
  });
}
