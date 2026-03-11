import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'config/theme.dart';
import 'layouts/splash.dart';
import 'layouts/login.dart';
import 'layouts/dashboard.dart';
import 'layouts/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Novapay TPV',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      routes: {
        LoginScreen.routename: (context) => const LoginScreen(),
        SplashScreen.routename: (context) => const SplashScreen(),
        DashboardScreen.routename: (context) => const DashboardScreen(),
        HomeScreen.routename: (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}