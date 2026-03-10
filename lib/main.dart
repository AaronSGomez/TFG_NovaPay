import 'package:flutter/material.dart';
import 'db/isar.dart';
import 'layouts/login.dart';
import 'layouts/dashboard.dart';
import 'layouts/home.dart';
import 'services/userServices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = await openIsar();
  await seedAdmin(isar);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginScreen(),
      routes: {
        LoginScreen.routename: (context) => const LoginScreen(),
        DashboardScreen.routename: (context) => const DashboardScreen(),
        HomeScreen.routename: (context) => const HomeScreen(),
      },
    );
  }
}
