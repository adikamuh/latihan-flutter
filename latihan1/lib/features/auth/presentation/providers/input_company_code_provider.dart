import 'package:flutter/material.dart';
import 'package:latihan1/features/auth/domain/entities/company_entity.dart';
import 'package:latihan1/features/auth/domain/usecases/get_company_by_code.dart';
import 'package:latihan1/features/auth/domain/usecases/save_company_to_local.dart';

class InputCompanyCodeProvider extends ChangeNotifier {
  final GetCompanyByCode getCompanyByCode;
  final SaveCompanyToLocal saveCompanyToLocal;

  InputCompanyCodeProvider({
    required this.getCompanyByCode,
    required this.saveCompanyToLocal,
  });

  final TextEditingController codeController = TextEditingController();
  CompanyEntity? company;

  Future<void> checkCompanyCode() async {
    try {
      final company = await getCompanyByCode.call(codeController.text);
      if (company != null) {
        this.company = company;
        // navigate to login
      } else {}
    } catch (e, s) {}
  }

  Future<void> submitCode() async {
    final code = codeController.text;
    // asumsi sudah berhasil get company by code
    final companyEntity = CompanyEntity(
      id: "id",
      code: code,
      name: "Company Name",
      logoUrl: "https://example.com/logo.png",
    );
    company = companyEntity;
    notifyListeners();
    await saveToLocalDB(companyEntity);
  }

  Future<void> saveToLocalDB(CompanyEntity company) async {
    await saveCompanyToLocal.call(company);
  }
}
