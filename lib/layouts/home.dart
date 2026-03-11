import 'package:flutter/material.dart';
import '../db/entities/user.dart';
import '../db/isar.dart';
import '../services/userServices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routename = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _user;
  bool _initialized = false;

  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      // Intentamos obtener el usuario de los argumentos
      final args = ModalRoute.of(context)!.settings.arguments;

      if (args is User) {
        _user = args;
      } else {
        // SI NO HAY ARGUMENTOS (como ahora), creamos un usuario temporal
        // Esto evita que la app explote al iniciar directo en Home
        _user = User() 
          ..username = 'Marcos Admin'
          ..email = 'admin@novapay.com'
          ..phone = '123456789';
      }

      _usernameCtrl.text = _user.username ?? '';
      _phoneCtrl.text = _user.phone ?? '';
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    _user
      ..username = _usernameCtrl.text
      ..phone = _phoneCtrl.text;
    if (_passwordCtrl.text.isNotEmpty) {
      _user.password = _passwordCtrl.text;
    }
    final isar = await openIsar();
    await updateUser(isar, _user);
    if (!mounted) return;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Datos actualizados')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.teal,
              child: Text(
                (_user.username ?? _user.email ?? 'U')[0].toUpperCase(),
                style: const TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _user.username ?? _user.email ?? 'Usuario',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              _user.email ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Editar datos', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _usernameCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneCtrl,
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Nueva contraseña (opcional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Guardar cambios'),
                onPressed: _saveChanges,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
