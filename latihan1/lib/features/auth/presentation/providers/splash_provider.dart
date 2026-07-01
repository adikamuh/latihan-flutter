import 'package:flutter/material.dart';
import 'package:latihan1/core/services/app_log.dart';
import 'package:latihan1/features/auth/domain/usecases/get_tenant.dart';
import 'package:latihan1/features/auth/presentation/views/login_view.dart';
import 'package:latihan1/features/auth/presentation/views/tenant_view.dart';
import 'package:latihan1/main.dart';

class SplashProvider extends ChangeNotifier {
  final GetTenant getTenantUsecase;
  SplashProvider({required this.getTenantUsecase});

  Future<void> checkTenant(String? code) async {
    try {
      final tenant = await getTenantUsecase.call(code);
      if (tenant != null) {
        Navigator.of(
          navigatorKey.currentContext!,
        ).pushReplacement(MaterialPageRoute(builder: (context) => LoginView()));
      } else {
        Navigator.of(navigatorKey.currentContext!).pushReplacement(
          MaterialPageRoute(builder: (context) => TenantView()),
        );
      }
    } catch (e, s) {
      AppLog.instance.logError("Error checking tenant", e, s);
      Navigator.of(
        navigatorKey.currentContext!,
      ).pushReplacement(MaterialPageRoute(builder: (context) => TenantView()));
    }
  }
}
