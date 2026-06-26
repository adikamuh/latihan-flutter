import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latihan1/core/constants/app_const.dart';
import 'package:latihan1/core/services/app_log.dart';
import 'package:latihan1/core/services/secured_storage_service.dart';
import 'package:latihan1/features/auth/data/models/tenant_payload.dart';
import 'package:latihan1/features/auth/domain/entities/tenant_entity.dart';
import 'package:latihan1/features/auth/domain/usecases/tenant_usecase.dart';

class TenantProvider extends ChangeNotifier {
  final TenantUsecase tenantUsecase;
  TenantProvider({required this.tenantUsecase});

  final TextEditingController codeController = TextEditingController();

  String username = '';
  TenantEntity? tenantData;
  bool isLoading = false;
  String errorMessage = '';

  void setTenantData(TenantEntity? data) {
    tenantData = data;
    notifyListeners();
  }

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    errorMessage = message;
    notifyListeners();
  }

  Future<void> code() async {
    setLoading(true);
    try {
      final payload = TenantPayload(code: codeController.text);
      final result = await tenantUsecase.call(payload);

      if (result == null) {
        setErrorMessage('Login failed: No data received');
        return;
      }
      setTenantData(result);
      await _saveTenantData(result);
    } on DioException catch (e, s) {
      AppLog.instance.logError('Verify code failed with DioException', e, s);
      setErrorMessage('Verify code failed: ${e.message}');
    } catch (e, s) {
      AppLog.instance.logError('Verify code failed', e, s);
      setErrorMessage('Verify code failed: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  Future<void> _saveTenantData(TenantEntity data) async {
    await SecuredStorageService.writeValue(
      AppConst.keyUser,
      jsonEncode(data.toJson()),
    );
  }
}
