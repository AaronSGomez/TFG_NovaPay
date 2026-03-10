import 'package:flutter/material.dart';
import '../db/entities/user.dart';
import '../db/isar.dart';
import '../services/userServices.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  static const String routename = 'dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<User> _users = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final isar = await openIsar();
    final users = await getAllUsers(isar);
    setState(() {
      _users = users;
      _loading = false;
    });
  }

  Future<void> _deleteUser(int id) async {
    final isar = await openIsar();
    await deleteUser(isar, id);
    await _loadUsers();
  }

  void _showCreateDialog() {
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final usernameCtrl = TextEditingController();
    String selectedRole = 'user';

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Nuevo usuario'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedRole,
                decoration: const InputDecoration(labelText: 'Rol'),
                items: const [
                  DropdownMenuItem(value: 'user', child: Text('Usuario')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                ],
                onChanged: (v) => setDialogState(() => selectedRole = v!),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (emailCtrl.text.isEmpty || passCtrl.text.isEmpty) return;
                final isar = await openIsar();
                final user = User()
                  ..username = usernameCtrl.text
                  ..email = emailCtrl.text
                  ..password = passCtrl.text
                  ..role = selectedRole;
                await isar.writeTxn(() async => await isar.users.put(user));
                if (mounted) Navigator.pop(ctx);
                await _loadUsers();
              },
              child: const Text('Crear'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(User user) {
    final emailCtrl = TextEditingController(text: user.email ?? '');
    final passCtrl = TextEditingController(text: user.password ?? '');
    final usernameCtrl = TextEditingController(text: user.username ?? '');
    String selectedRole = user.role;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Editar usuario'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedRole,
                decoration: const InputDecoration(labelText: 'Rol'),
                items: const [
                  DropdownMenuItem(value: 'user', child: Text('Usuario')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                ],
                onChanged: (v) => setDialogState(() => selectedRole = v!),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                user
                  ..username = usernameCtrl.text
                  ..email = emailCtrl.text
                  ..password = passCtrl.text
                  ..role = selectedRole;
                final isar = await openIsar();
                await updateUser(isar, user);
                if (mounted) Navigator.pop(ctx);
                await _loadUsers();
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de usuarios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _users.isEmpty
              ? const Center(child: Text('No hay usuarios registrados'))
              : ListView.separated(
                  itemCount: _users.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (_, i) {
                    final u = _users[i];
                    final isAdmin = u.role == 'admin';
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isAdmin ? Colors.indigo : Colors.teal,
                        child: Icon(
                          isAdmin ? Icons.admin_panel_settings : Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(u.username ?? u.email ?? 'Sin nombre'),
                      subtitle: Text(u.email ?? ''),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Chip(
                            label: Text(isAdmin ? 'Admin' : 'Usuario'),
                            backgroundColor: isAdmin ? Colors.indigo[100] : Colors.teal[100],
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showEditDialog(u),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteUser(u.id),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDialog,
        tooltip: 'Nuevo usuario',
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
