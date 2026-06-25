import 'package:flutter/material.dart';
import 'package:latihan1/core/di/service_locator.dart';
import 'package:latihan1/features/auth/presentation/providers/input_company_code_provider.dart';
import 'package:provider/provider.dart';

class InputCompanyCodeView extends StatelessWidget {
  const InputCompanyCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => InputCompanyCodeProvider(
        getCompanyByCode: sl(),
        saveCompanyToLocal: sl(),
      ),
      child: Scaffold(
        body: Consumer<InputCompanyCodeProvider>(
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
