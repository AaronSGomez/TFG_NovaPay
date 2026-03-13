// lib/presentation/pages/admin/sections/users_list_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/user_controller.dart';
import '../../../widgets/common/user_form_dialog.dart';

class UsersListSection extends StatelessWidget {
  const UsersListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userCtrl = Get.find<UserController>();

    return Obx(() {
      if (userCtrl.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (userCtrl.users.isEmpty) {
        return const Center(child: Text('No hay usuarios registrados'));
      }

      return Scaffold(
        body: ListView.separated(
          itemCount: userCtrl.users.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (_, i) {
            final u       = userCtrl.users[i];
            final isAdmin = u.role == 'admin';
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: isAdmin ? Colors.indigo : Colors.teal,
                child: Icon(
                  isAdmin ? Icons.admin_panel_settings : Icons.person,
                  color: Colors.white,
                ),
              ),
              title:    Text(u.username ?? u.email ?? 'Sin nombre'),
              subtitle: Text(u.email ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Chip(
                    label:           Text(isAdmin ? 'Admin' : 'Usuario'),
                    backgroundColor: isAdmin ? Colors.indigo[100] : Colors.teal[100],
                  ),
                  IconButton(
                    icon:      const Icon(Icons.edit),
                    onPressed: () =>
                        UserFormDialog.showEdit(context, userCtrl, u),
                  ),
                  IconButton(
                    icon:      const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => userCtrl.remove(u.id),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => UserFormDialog.showCreate(context, userCtrl),
          tooltip:   'Nuevo usuario',
          child:     const Icon(Icons.person_add),
        ),
      );
    });
  }
}
