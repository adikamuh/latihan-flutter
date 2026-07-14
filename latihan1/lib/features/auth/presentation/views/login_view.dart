import 'package:flutter/material.dart';
import 'package:latihan1/core/di/service_locator.dart';
import 'package:latihan1/features/auth/presentation/providers/auth_provider.dart';
import 'package:latihan1/features/auth/presentation/providers/tenant_provider.dart';
import 'package:latihan1/main.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _authProvider = sl<AuthProvider>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleLogin() async {
    FocusScope.of(context).unfocus();
    await _authProvider.login();

    if (_authProvider.loginData != null && _authProvider.errorMessage.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login Successful!')));
      }
    } else if (_authProvider.errorMessage.isNotEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_authProvider.errorMessage)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _authProvider,
      // Gunakan Consumer2 untuk mengakses AuthProvider dan TenantProvider
      child: Consumer2<AuthProvider, TenantProvider>(
        builder: (context, authProvider, tenantProvider, child) {
          return Scaffold(
            // Warna background bawah (hijau abu-abu muda)
            backgroundColor: const Color(0xFFF6F8F6),
            body: Column(
              children: [
                // 1. HEADER BIRU TUA DENGAN LOGO
                Container(
                  width: double.infinity,
                  height: 260,
                  padding: const EdgeInsets.only(
                    top: 50,
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
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.maybePop(context);
                            } else {
                              navigatorKey.currentState?.pop();
                            }
                          },
                        ),
                      ),
                      // Logo Tenant (dari TenantEntityIsar)
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:
                              tenantProvider.logoUrl != null &&
                                  tenantProvider.logoUrl!.isNotEmpty
                              ? Image.network(
                                  tenantProvider.logoUrl!,
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

                // 2. KARTU PUTIH (BAGIAN LOGIN)
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
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                          // Opsional tambahkan shadow halus:
                          // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -4))]
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Welcome Back 👋",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Enter your email or NIK and Password for login this app",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Input Email or NIK
                              const Text(
                                "Email or NIK",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: authProvider.loginController,
                                decoration: InputDecoration(
                                  hintText: "Email or Employee ID",
                                  filled: true,
                                  fillColor: Colors.white,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF7CB342),
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 18,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Input Password
                              const Text(
                                "Password",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: authProvider.passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Your password",
                                  filled: true,
                                  fillColor: Colors.white,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF7CB342),
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 18,
                                  ),
                                  // Ikon mata untuk toggle visibility (opsional jika mau ditambahkan)
                                  suffixIcon: Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Forgot Password Link
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    // Navigasi ke halaman lupa password
                                  },
                                  child: const Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                      color: Color(0xFF5C6BC0),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Tombol LOGIN (Hijau)
                              SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: authProvider.isLoading
                                      ? null
                                      : _handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(
                                      0xFF7CB342,
                                    ), // Hijau
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: authProvider.isLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          "LOGIN",
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
