import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latihan1/core/constants/app_const.dart';
import 'package:latihan1/core/services/app_log.dart';
import 'package:latihan1/core/services/secured_storage_service.dart';
import 'package:latihan1/features/auth/data/models/login_payload.dart';
import 'package:latihan1/features/auth/domain/entities/login_entity.dart';
import 'package:latihan1/features/auth/domain/usecases/login_usecase.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUsecase loginUsecase;
  AuthProvider({required this.loginUsecase});

  final TextEditingController codeController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String username = '';
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
      final payload = LoginPayload(
        code: codeController.text,
        login: loginController.text,
        password: passwordController.text,
      );
      final result = await loginUsecase.call(payload);

      if (result == null) {
        setErrorMessage('Login failed: No data received');
        return;
      }
      setLoginData(result);
      await _saveLoginData(result);
    } on DioException catch (e, s) {
      AppLog.instance.logError('Login failed with DioException', e, s);
      setErrorMessage('Login failed: ${e.message}');
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
}
