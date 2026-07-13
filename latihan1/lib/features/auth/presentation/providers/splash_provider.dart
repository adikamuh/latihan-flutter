import 'package:flutter/material.dart';
import 'package:latihan1/core/services/app_log.dart';
import 'package:latihan1/features/auth/domain/usecases/check_auth.dart';
import 'package:latihan1/features/auth/domain/usecases/get_tenant.dart';
import 'package:latihan1/features/auth/presentation/views/tenant_view.dart';
import 'package:latihan1/main.dart';

class SplashProvider extends ChangeNotifier {
  final GetTenant getTenantUsecase;
  final CheckAuth checkAuthUsecase;
  SplashProvider({
    required this.getTenantUsecase,
    required this.checkAuthUsecase,
  });

  Future<void> checkTenant(String? code) async {
    try {
      final tenant = await getTenantUsecase.call(code, false);
      if (tenant != null) {
        final auth = await checkAuthUsecase.call();
        if (auth != null) {
          Navigator.of(navigatorKey.currentContext!).pushReplacement(
            MaterialPageRoute(builder: (context) => TenantView()),
          );
        } else {
          Navigator.of(navigatorKey.currentContext!).pushReplacement(
            MaterialPageRoute(builder: (context) => TenantView()),
          );
        }
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
