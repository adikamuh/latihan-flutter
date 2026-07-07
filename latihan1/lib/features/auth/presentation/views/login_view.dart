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
      child: Consumer2<AuthProvider, TenantProvider>(
        builder: (context, authProvider, tenantProvider, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.maybePop(context);
                  } else {
                    navigatorKey.currentState?.pop();
                  }
                },
              ),
            ),
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
                    const SizedBox(height: 60),

                    // 1. Company Logo
                    SizedBox(
                      height: 120,
                      width: 120,
                      child:
                          tenantProvider.logoUrl != null &&
                              tenantProvider.logoUrl!.isNotEmpty
                          ? Image.network(
                              tenantProvider.logoUrl!,
                              errorBuilder: (context, error, stackTrace) {
                                return const FlutterLogo(size: 100);
                              },
                            )
                          : const FlutterLogo(size: 100),
                    ),

                    const SizedBox(height: 80),

                    // 2. Login Title
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 3. Subtitle
                    const Text(
                      "Enter your code, email or NIK and Password\nfor login this app",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // 5. Email or NIK Text Field
                    TextField(
                      controller: authProvider.loginController,
                      decoration: InputDecoration(
                        labelText: "Email or NIK",
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
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 6. Password Text Field
                    TextField(
                      controller: authProvider.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
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
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 7. Login Button (Menampilkan Loading Indicator jika isLoading)
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: authProvider.isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: authProvider.isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 8. Forgot Password Link
                    TextButton(
                      onPressed: () {
                        // Navigasi ke halaman lupa password
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
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
