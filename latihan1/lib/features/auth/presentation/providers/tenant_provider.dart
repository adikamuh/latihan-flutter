import 'package:flutter/material.dart';
import 'package:latihan1/features/auth/domain/entities/tenant_entity.dart';
import 'package:latihan1/features/auth/domain/usecases/get_tenant.dart';
import 'package:latihan1/features/auth/domain/usecases/save_tenant.dart';

class TenantProvider extends ChangeNotifier {
  final GetTenant getTenant;
  final SaveTenant saveTenant;

  TenantProvider({required this.getTenant, required this.saveTenant});

  final TextEditingController codeController = TextEditingController();
  TenantEntity? tenant;

  Future<void> checkTenantCode() async {
    try {
      final tenant = await getTenant.call(codeController.text);
      if (tenant != null) {
        this.tenant = tenant;
        // navigate to login
      } else {}
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> submitCode() async {
    final code = codeController.text;
    // asumsi sudah berhasil get company by code
    final tenantEntity = TenantEntity(
      id: "id",
      code: code,
      name: "Company Name",
      logo: "https://example.com/logo.png",
    );
    tenant = tenantEntity;
    notifyListeners();
    await saveToLocalDB(tenantEntity);
  }

  Future<void> saveToLocalDB(TenantEntity tenant) async {
    await saveTenant.call(tenant);
  }
}
