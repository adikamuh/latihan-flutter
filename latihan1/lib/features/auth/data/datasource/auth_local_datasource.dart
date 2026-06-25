import 'package:latihan1/features/auth/data/models/company_entity_isar.dart';
import 'package:latihan1/features/auth/domain/entities/company_entity.dart';

abstract class AuthLocalDatasource {
  Future<CompanyEntityIsar?> getCompanyByCode(String code);
  Future<void> saveCompanyToLocalDB(CompanyEntityIsar company);
}
