import 'package:flutter/material.dart';
import '../config/theme.dart';
import 'login.dart';

/// Pantalla de presentación (Splash/Onboarding) de Novapay TPV
/// Muestra el logo y presentación de la app durante 3 segundos
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  
  static const String routename = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    // Después de 3 segundos, navega a LoginScreen
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routename);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background, // Blanco
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo o icono de Novapay
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primary, // Morado vibrante
              ),
              child: const Center(
                child: Text(
                  'N',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Título
            Text(
              'Novapay TPV',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 16),
            
            // Subtítulo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Gestiona tu negocio con eficiencia',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 60),
            
            // Indicador de carga
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.secondary),
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}