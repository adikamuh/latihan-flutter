import 'package:isar_community/isar.dart';
import 'package:latihan1/features/auth/domain/entities/company_entity.dart';

part 'company_entity_isar.g.dart';

@collection
class CompanyEntityIsar extends CompanyEntity {
  final Id idIsar;
  CompanyEntityIsar({
    this.idIsar = Isar.autoIncrement,
    required super.id,
    required super.name,
    required super.code,
    required super.logoUrl,
  });
}
