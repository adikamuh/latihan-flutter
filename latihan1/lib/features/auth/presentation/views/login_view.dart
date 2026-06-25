import 'package:flutter/material.dart';
import 'package:latihan1/core/di/service_locator.dart';
import 'package:latihan1/features/auth/presentation/providers/auth_provider.dart';
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
    // Mengambil instance AuthProvider dari GetIt
    _authProvider = sl<AuthProvider>();
  }

  @override
  void dispose() {
    // Controller sudah di dispose oleh AuthProvider,
    // namun kita tetap membersihkan provider jika perlu.
    super.dispose();
  }

  void _handleLogin() async {
    // Menutup keyboard saat login ditekan
    FocusScope.of(context).unfocus();

    // Panggil fungsi login dari provider
    await _authProvider.login();

    // Cek jika login berhasil dan tidak ada error
    if (_authProvider.loginData != null && _authProvider.errorMessage.isEmpty) {
      // TODO: Arahkan ke halaman Home/Dashboard di sini
      // Example: Navigator.pushReplacementNamed(context, '/home');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login Successful!')));
      }
    } else if (_authProvider.errorMessage.isNotEmpty) {
      // Tampilkan pesan error jika ada
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_authProvider.errorMessage)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Menggunakan Consumer agar UI rebuild saat state di AuthProvider berubah
    return ChangeNotifierProvider.value(
      value: _authProvider,
      child: Consumer<AuthProvider>(
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
                    const SizedBox(height: 60),

                    // 1. Company Logo
                    const Text(
                      "[Company Logo]",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
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

                    // 4. Code Text Field (Baru ditambahkan sesuai request)
                    TextField(
                      controller: provider.codeController,
                      decoration: InputDecoration(
                        labelText: "Code",
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

                    // 5. Email or NIK Text Field
                    TextField(
                      controller: provider.loginController,
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
                      controller: provider.passwordController,
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
                        onPressed: provider.isLoading ? null : _handleLogin,
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

                    const SizedBox(height: 30),

                    // 9. Footer / Terms of Service
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: "By clicking continue, you agree to our ",
                          ),
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: "\nand "),
                          TextSpan(
                            text: "Privacy Policy",
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
          );
        },
      ),
    );
  }
}
