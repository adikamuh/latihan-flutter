import 'package:flutter/material.dart';
import 'package:latihan1/core/di/service_locator.dart';
import 'package:latihan1/features/auth/presentation/providers/auth_provider.dart';
import 'package:latihan1/features/auth/presentation/views/splash_view.dart';
import 'package:logarte/logarte.dart';
import 'package:provider/provider.dart';

final Logarte logarte = Logarte();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependecies();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider.value(value: sl<AuthProvider>())],
      child: const MaterialApp(home: SplashView()),
    );
  }
}
