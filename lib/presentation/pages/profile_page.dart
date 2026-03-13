// lib/presentation/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/user.dart';
import '../widgets/profile/profile_form_widget.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  static const String routename = '/profile';

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final user = args is User ? args : User();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () => Get.offNamed(LoginPage.routename),
          ),
        ],
      ),
      body: ProfileFormWidget(user: user),
    );
  }
}
