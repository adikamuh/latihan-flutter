import 'package:latihan1/features/auth/domain/entities/company_entity.dart';
import 'package:latihan1/features/auth/domain/repositories/auth_repository.dart';

class SaveCompanyToLocal {
  final AuthRepository repository;

  SaveCompanyToLocal(this.repository);

  Future<void> call(CompanyEntity company) async {
    // await repository.saveCompanyToLocalDB(company);
    
  }
}
