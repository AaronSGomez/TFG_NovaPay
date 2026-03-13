// lib/presentation/controllers/config_controller.dart
import 'package:get/get.dart';
import '../../data/models/config.dart';
import '../../data/models/business_config.dart';
import '../../services/config_service.dart';

class ConfigController extends GetxController {
  final ConfigService _service;
  ConfigController(this._service);

  final config         = Rxn<Config>();
  final businessConfig = Rxn<BusinessConfig>();
  final isLoading      = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAll();
  }

  Future<void> loadAll() async {
    try {
      isLoading.value = true;
      config.value         = await _service.getConfig();
      businessConfig.value = await _service.getBusinessConfig();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo cargar la configuración');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateConfig(Config updated) async {
    try {
      await _service.saveConfig(updated);
      config.value = updated;
    } catch (e) {
      Get.snackbar('Error', 'No se pudo guardar la configuración');
    }
  }

  Future<void> updateBusinessConfig(BusinessConfig updated) async {
    try {
      await _service.saveBusinessConfig(updated);
      businessConfig.value = updated;
    } catch (e) {
      Get.snackbar('Error', 'No se pudo guardar la configuración del negocio');
    }
  }

  String get businessName => businessConfig.value?.businessName ?? '';
  String get businessMode => config.value?.businessMode ?? 'bar';
  String get cifNif       => businessConfig.value?.cifNif ?? '';
  String get address      => businessConfig.value?.address ?? '';

  bool verifyAdminPassword(String input) {
    return businessConfig.value?.adminPassword == input;
  }
}
