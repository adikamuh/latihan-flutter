import 'package:isar_community/isar.dart';
import 'package:latihan1/core/services/isar_service.dart';
import 'package:latihan1/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:latihan1/features/auth/data/models/company_entity_isar.dart';
import 'package:latihan1/features/auth/domain/entities/company_entity.dart';

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final Isar _isar;
  AuthLocalDatasourceImpl(this._isar);

  @override
  Future<CompanyEntityIsar?> getCompanyByCode(String code) async {
    final company = await _isar.companyEntityIsars
        .filter()
        .codeEqualTo(code)
        .findFirst();
    return company;
  }

  @override
  Future<void> saveCompanyToLocalDB(CompanyEntityIsar company) async {
    await _isar.writeTxn(() async {
      await _isar.companyEntityIsars.put(company);
    });
  }
}
