import 'package:flutter/material.dart';
import 'package:latihan1/features/auth/presentation/providers/input_company_code_provider.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InputCompanyCodeProvider>(
        builder: (context, provider, child) {
          return Center(
            child: Image.network(
              provider.company?.logoUrl ??
                  'https://example.com/default_logo.png',
            ),
          );
        },
      ),
    );
  }
}
