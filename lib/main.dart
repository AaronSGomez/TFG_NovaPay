import 'package:flutter/material.dart';
import 'config/theme.dart';
import 'layouts/splash.dart';
import 'layouts/login.dart';
import 'layouts/dashboard.dart';
import 'layouts/home.dart';

// Comentamos esto temporalmente hasta que conectemos la lógica
// import 'db/isar.dart';
// import 'services/userServices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Dejaremos la conexión a la base de datos para más adelante
  // final isar = await openIsar();
  // await seedAdmin(isar);
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Más adelante lo cambiaremos a GetMaterialApp
      title: 'Novapay TPV',
      theme: AppTheme.lightTheme, // ¡Aquí tu tema de Material 3 está cobrando vida!
      
      // Cambiamos el inicio directo al Home
      home: const SplashScreen(), 
      
      routes: {
        LoginScreen.routename: (context) => const LoginScreen(),
        SplashScreen.routename: (context) => const SplashScreen(),
        DashboardScreen.routename: (context) => const DashboardScreen(),
        HomeScreen.routename: (context) => const HomeScreen(),
      },
      // Quita la etiqueta de "DEBUG" de la esquina superior derecha
      debugShowCheckedModeBanner: false, 
    );
  }
}