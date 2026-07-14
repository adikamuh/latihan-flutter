import 'package:flutter/material.dart';
import 'package:latihan1/core/di/service_locator.dart';
import 'package:latihan1/features/auth/presentation/providers/tenant_provider.dart';
import 'package:latihan1/features/auth/presentation/views/confirm_view.dart';
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ConfirmView()),
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
            // Warna background bawah (hijau abu-abu muda)
            backgroundColor: const Color(0xFFF6F8F6),
            body: Column(
              children: [
                // 1. HEADER BIRU TUA
                Container(
                  width: double.infinity,
                  height: 240,
                  padding: const EdgeInsets.only(
                    top: 60,
                    left: 20,
                    right: 20,
                    bottom: 30,
                  ),
                  decoration: const BoxDecoration(color: Color(0xFF113355)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo di dalam kotak putih melengkung (Logo Flutter dipertahankan)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
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
                      const SizedBox(height: 12),
                      const Text(
                        "Your Smart Attendance Solution",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                // 2. KARTU PUTIH (BAGIAN BAWAH)
                Expanded(
                  child: Container(
                    color: const Color(0xFFF6F8F6),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        // Margin negatif ke atas agar menumpuk dengan header biru
                        margin: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24),
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
                              "Company Setup",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Enter your company access code to continue.",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Info Chip Hijau
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 16,
                                    color: Color(0xFF388E3C),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Get your code from HR or Admin',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF388E3C),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Label Input
                            const Text(
                              "Company Code",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // TextField Input
                            TextField(
                              controller: provider.codeController,
                              enabled: !provider.isLoading,
                              decoration: InputDecoration(
                                hintText: "e.g. STIMOBILE2024",
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF113355),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Tombol SUBMIT (Hijau)
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: provider.isLoading
                                    ? null
                                    : _handleContinue,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF7CB342),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                                child: provider.isLoading
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        "SUBMIT",
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
