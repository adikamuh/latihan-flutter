import 'package:latihan1/features/auth/data/models/login_payload.dart';
import 'package:latihan1/features/auth/domain/entities/company_entity.dart';
import 'package:latihan1/features/auth/domain/entities/login_entity.dart';

abstract class AuthRepository {
  Future<LoginEntity?> login(LoginPayload payload);
  Future<void> logout();
  Future<CompanyEntity?> getCompanyByCode(String code);
  Future<void> saveCompanyToLocalDB(CompanyEntity company);
}
