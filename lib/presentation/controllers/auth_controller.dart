// lib/presentation/controllers/auth_controller.dart
import 'package:get/get.dart';

import '../../data/models/user.dart';
import '../../services/user_service.dart';

class AuthController extends GetxController {
  final UserService _service;
  AuthController(this._service);

  final currentUser = Rxn<User>();
  final isLoading   = false.obs;

  Future<bool> login(String identifier, String password) async {
    try {
      isLoading.value = true;
      final user = await _service.login(identifier, password);
      if (user == null) return false;
      currentUser.value = user;
      return true;
    } catch (e) {
      Get.snackbar('Error', 'No se pudo iniciar sesión');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    currentUser.value = null;
  }

  bool get isAdmin => currentUser.value?.role == 'admin';
}
