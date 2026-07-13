import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:latihan1/core/constants/app_const.dart';
import 'package:latihan1/core/services/app_log.dart';
import 'package:latihan1/core/services/device_info_service.dart';
import 'package:latihan1/core/services/secured_storage_service.dart';
import 'package:latihan1/features/auth/data/models/login_payload.dart';
import 'package:latihan1/features/auth/domain/entities/login_entity.dart';
import 'package:latihan1/features/auth/domain/repositories/auth_repository.dart';
import 'package:latihan1/features/auth/domain/usecases/get_tenant.dart';
import 'package:latihan1/features/auth/domain/usecases/login_usecase.dart';
import 'package:latihan1/features/auth/presentation/views/main_view.dart';
import 'package:latihan1/features/auth/presentation/views/splash_view.dart';
import 'package:latihan1/main.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUsecase loginUsecase;
  final GetTenant getTenantUsecase;
  final AuthRepository authRepository;

  AuthProvider({
    required this.loginUsecase,
    required this.getTenantUsecase,
    required this.authRepository,
  });

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginEntity? loginData;
  bool isLoading = false;
  String errorMessage = '';

  void setLoginData(LoginEntity? data) {
    loginData = data;
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

  Future<void> login() async {
    setLoading(true);
    try {
      final deviceInfo = await DeviceInfoService().getDeviceInfo();
      final tenantCode = await getTenantUsecase.call(null, false);
      if (tenantCode == null || (tenantCode.code?.isEmpty ?? true)) {
        setErrorMessage('Tenant code not found');
        return;
      }
      final payload = LoginPayload(
        code: tenantCode.code!,
        login: loginController.text,
        password: passwordController.text,
        deviceUuid: deviceInfo['deviceId'] as String? ?? '',
        deviceInfo: deviceInfo['platform'] as String? ?? '',
      );
      final result = await loginUsecase.call(payload);

      if (result == null) {
        setErrorMessage('Login failed: No data received');
        return;
      } else {
        setLoginData(result);
        await _saveLoginData(result);
        Navigator.of(
          navigatorKey.currentContext!,
        ).pushReplacement(MaterialPageRoute(builder: (context) => MainView()));
      }
    } catch (e, s) {
      AppLog.instance.logError('Login failed', e, s);
      setErrorMessage('Login failed: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  Future<void> _saveLoginData(LoginEntity data) async {
    await SecuredStorageService.writeValue(
      AppConst.keyUser,
      jsonEncode(data.toJson()),
    );
  }

  Future<void> logout() async {
    setLoading(true);
    try {
      await SecuredStorageService.deleteAll();
      await authRepository.logout();
      setLoginData(null);
      Navigator.of(navigatorKey.currentContext!).pushReplacement(
        MaterialPageRoute(builder: (context) => const SplashView()),
      );
    } on Exception catch (e, s) {
      AppLog.instance.logError('Logout failed', e, s);
    } finally {
      setLoading(false);
    }
  }
}
