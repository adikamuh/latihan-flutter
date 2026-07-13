import 'package:flutter/material.dart';
import 'package:latihan1/core/di/service_locator.dart';
import 'package:latihan1/features/auth/presentation/providers/tenant_provider.dart';
import 'package:latihan1/features/auth/presentation/views/login_view.dart';
import 'package:provider/provider.dart';

class ConfirmView extends StatelessWidget {
  const ConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil provider yang sudah terdaftar di GetIt (data tenant sudah tersimpan)
    final tenantProvider = sl<TenantProvider>();

    return ChangeNotifierProvider.value(
      value: tenantProvider,
      child: Consumer<TenantProvider>(
        builder: (context, provider, child) {
          final company = provider.companyData;

          // Jika data null (misal user reload page), fallback ke TenantView
          if (company == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
            });
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            backgroundColor: const Color(0xFFF6F8F6),
            body: Column(
              children: [
                // --- 1. HEADER BIRU TUA (Dengan Logo dan Back Button) ---
                Container(
                  width: double.infinity,
                  height: 260,
                  padding: const EdgeInsets.only(
                    top: 60,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  decoration: const BoxDecoration(color: Color(0xFF113355)),
                  child: Stack(
                    children: [
                      // Tombol Kembali
                      Positioned(
                        top: 0,
                        left: 0,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      // Logo Perusahaan / FlutterLogo
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:
                              provider.logoUrl != null &&
                                  provider.logoUrl!.isNotEmpty
                              ? Image.network(
                                  provider.logoUrl!,
                                  width: 80,
                                  height: 80,
                                  errorBuilder: (_, _, _) =>
                                      const FlutterLogo(size: 80),
                                )
                              : const FlutterLogo(size: 80),
                        ),
                      ),
                    ],
                  ),
                ),

                // --- 2. KARTU PUTIH (BAGIAN KONFIRMASI) ---
                Expanded(
                  child: Container(
                    color: const Color(0xFFF6F8F6),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        // Margin negatif agar menumpuk ke atas
                        margin: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, -4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Company Found!",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "We found a company matching your access code.",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Kotak Info Perusahaan (Green Border)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF7CB342),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    company.name ?? "Unknown Company",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    // Ganti ini dengan company.address jika backend Anda mengirimkannya
                                    company.address ??
                                        "Graha Inti, Lt. 6, Jl. Kuningan Mulia No. 1, Jakarta Selatan",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),

                            const Text(
                              "Is this your company?",
                              style: TextStyle(
                                color: Color(0xFF5C6BC0),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Tombol YES, CONTINUE (Hijau)
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginView(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF7CB342),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  "YES, CONTINUE",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Tombol TRY A DIFFERENT CODE (Putih)
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Kembali ke TenantView, reset state jika perlu
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF113355),
                                  side: const BorderSide(
                                    color: Color(0xFF113355),
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  "TRY A DIFFERENT CODE",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Footer Terms & Privacy
                            RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: "By signing in, you agree to our ",
                                  ),
                                  TextSpan(
                                    text: "Terms of Service",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: " and "),
                                  TextSpan(
                                    text: "Privacy Policy.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
