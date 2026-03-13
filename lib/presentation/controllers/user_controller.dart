// lib/presentation/controllers/user_controller.dart
import 'package:get/get.dart';

import '../../data/models/user.dart';
import '../../services/user_service.dart';

class UserController extends GetxController {
  final UserService _service;
  UserController(this._service);

  final users     = <User>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAll();
  }

  Future<void> loadAll() async {
    try {
      isLoading.value = true;
      users.value = await _service.getAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar los usuarios');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> create(User user) async {
    try {
      await _service.save(user);
      await loadAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo crear el usuario');
    }
  }

  Future<void> save(User user) async {
    try {
      await _service.save(user);
      await loadAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo actualizar el usuario');
    }
  }

  Future<void> remove(int id) async {
    try {
      await _service.delete(id);
      await loadAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo eliminar el usuario');
    }
  }
}
