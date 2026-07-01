import 'package:flutter/material.dart';
import 'package:latihan1/features/auth/domain/entities/tenant_entity.dart';
import 'package:latihan1/features/auth/domain/usecases/get_tenant.dart';
import 'package:latihan1/features/auth/domain/usecases/save_tenant.dart';

class TenantProvider extends ChangeNotifier {
  final GetTenant getTenant;
  final SaveTenant saveTenant;

  TenantProvider({required this.getTenant, required this.saveTenant});

  final TextEditingController codeController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';
  String? logoUrl;
  TenantEntity? companyData;

  void _setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void _setErrorMessage(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void _setLogoUrl(String? url) {
    logoUrl = url;
    notifyListeners();
  }

  void _setCompanyData(TenantEntity? data) {
    companyData = data;
    notifyListeners();
  }

  Future<void> submitCode() async {
    final code = codeController.text.trim();
    if (code.isEmpty) {
      _setErrorMessage('Please enter your company code');
      return;
    }

    _setLoading(true);
    _setErrorMessage('');
    _setLogoUrl(null);
    _setCompanyData(null);

    try {
      final result = await getTenant.call(code);

      if (result != null) {
        _setLogoUrl(result.logo ?? '');
        _setCompanyData(result);

        await saveToLocalDB(result);
      } else {
        _setErrorMessage('Company code is invalid or not found');
      }
    } catch (e) {
      _setErrorMessage('Failed to connect to server. Please try again.');
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> saveToLocalDB(TenantEntity tenant) async {
    await saveTenant.call(tenant);
  }
}
