import 'package:flutter/material.dart';
import 'package:latihan1/core/di/service_locator.dart';
import 'package:latihan1/features/auth/presentation/providers/tenant_provider.dart';
import 'package:latihan1/features/auth/presentation/views/login_view.dart';
import 'package:provider/provider.dart';

class TenantView extends StatefulWidget {
  const TenantView({super.key});

  @override
  State<TenantView> createState() => _TenantViewState();
}

class _TenantViewState extends State<TenantView> {
  late final TenantProvider _tenantProvider;

  @override
  void initState() {
    super.initState();
    _tenantProvider = sl<TenantProvider>();
  }

  void _handleContinue() async {
    FocusScope.of(context).unfocus();

    // Panggil fungsi API dari provider
    await _tenantProvider.submitCode();

    // Jika berhasil dan logo sudah terload, pindah ke LoginView
    if (mounted && _tenantProvider.companyData != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _tenantProvider,
      child: Consumer<TenantProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    // 1. Judul Aplikasi
                    const Text(
                      "STI Mobile",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 2. Tempat Logo
                    SizedBox(
                      height: 120,
                      width: 120,
                      child:
                          provider.logoUrl != null &&
                              provider.logoUrl!.isNotEmpty
                          ? Image.network(
                              provider.logoUrl!,
                              errorBuilder: (context, error, stackTrace) {
                                return const FlutterLogo(size: 100);
                              },
                            )
                          : const FlutterLogo(size: 100),
                    ),
                    const SizedBox(height: 120),

                    // 3. Input Company Code
                    TextField(
                      controller: provider.codeController,
                      enabled: !provider.isLoading,
                      decoration: InputDecoration(
                        labelText: "Your Company Code",
                        labelStyle: const TextStyle(color: Colors.grey),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        errorText: provider.errorMessage.isNotEmpty
                            ? provider.errorMessage
                            : null,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 4. Tombol Continue
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: provider.isLoading ? null : _handleContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: provider.isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "Continue",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
