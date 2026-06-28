import 'package:flutter/material.dart';
import 'package:latihan1/core/di/service_locator.dart';
import 'package:latihan1/features/auth/presentation/providers/tenant_provider.dart';
import 'package:provider/provider.dart';

class TenantView extends StatelessWidget {
  const TenantView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          TenantProvider(getTenant: sl(), saveTenant: sl()),
      child: Scaffold(
        body: Consumer<TenantProvider>(
          builder: (context, provider, child) {
            return Center(
              child: Column(
                children: [
                  TextFormField(controller: provider.codeController),
                  ElevatedButton(
                    onPressed: provider.submitCode,
                    child: Text('Submit'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
