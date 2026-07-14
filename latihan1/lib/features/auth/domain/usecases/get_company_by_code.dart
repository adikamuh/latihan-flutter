import 'package:latihan1/features/auth/domain/entities/company_entity.dart';
import 'package:latihan1/features/auth/domain/repositories/auth_repository.dart';

class GetCompanyByCode {
  final AuthRepository repository;

  GetCompanyByCode(this.repository);

  Future<CompanyEntity?> call(String code) async {
    // return await repository.getCompanyByCode(code);
    return null;
  }
}
