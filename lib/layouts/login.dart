import 'package:flutter/material.dart';
import '../db/isar.dart';
import '../services/userServices.dart';

// ⚠️ Cambio a StatefulWidget para gestionar correctamente los controladores
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routename = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    // Libera los controladores cuando la pantalla se destruye
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bienvenido a NovaPay")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo adaptable según el tamaño del dispositivo
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 80,
                  maxHeight: 260,
                  minWidth: 80,
                  maxWidth: 360,
                ),
                child: Image.asset('assets/images/novapay.webp', fit: BoxFit.contain),
              ),
              const SizedBox(height: 32),
              // Campo de usuario
              TextField(
                controller: userController,
                decoration: const InputDecoration(
                  labelText: "Usuario o Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Campo de contraseña (obscureText oculta el texto)
              TextField(
                controller: passController,
                decoration: const InputDecoration(
                  labelText: "Contraseña",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              // Botón para iniciar sesión
              ElevatedButton(
                onPressed: () async {
                  final isar = await openIsar();
                  final user = await loginUser(isar, userController.text, passController.text);
                  if (!mounted) return;
                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Usuario o contraseña incorrectos')),
                    );
                    return;
                  }
                  final isAdmin = user.role == 'admin' || user.email == 'admin';
                  if (isAdmin) {
                    Navigator.pushReplacementNamed(context, 'dashboard');
                  } else {
                    Navigator.pushReplacementNamed(context, 'home', arguments: user);
                  }
                },
                child: const Text("Iniciar sesión"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}