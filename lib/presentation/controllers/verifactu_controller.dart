import 'package:get/get.dart';

import '../../data/models/user.dart';
import '../../data/models/verifactu_models.dart';
import '../../services/user_service.dart';
import '../../services/verifactu_service.dart';

class VerifactuController extends GetxController {
  final VerifactuService _service;
  final UserService _userService;
  VerifactuController(this._service, this._userService);

  final interactions = <FiscalInteraction>[].obs;
  final isLoading = false.obs;
  final isSubmitting = false.obs;
  final errorMessage = RxnString();
  final backendState = Rxn<VerifactuBackendState>();
  final adminUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    loadContext();
    refreshInteractions();
  }

  Future<void> loadContext() async {
    backendState.value = await _service.getBackendState();
    adminUser.value = await _userService.getAdmin();
  }

  Future<void> registerBackend({
    required String companyName,
    required String taxId,
    required String address,
    required bool isNewSystem,
    String? hash,
  }) async {
    try {
      isSubmitting.value = true;
      await _service.registerBackendUser(
        companyName: companyName,
        taxId: taxId,
        address: address,
        isNewSystem: isNewSystem,
        clientHash: hash,
      );
      backendState.value = await _service.getBackendState();
      Get.snackbar('Verifactu', 'Registro backend completado. Ahora autentica para activar el backend.');
    } catch (e) {
      Get.snackbar('Verifactu', 'Registro fallido: $e');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> authenticateNow() async {
    try {
      isSubmitting.value = true;
      await _service.authenticateBackend();
      backendState.value = await _service.getBackendState();
      Get.snackbar('Verifactu', 'Autenticación correcta. Backend habilitado por 15 días.');
      await refreshInteractions();
    } catch (e) {
      Get.snackbar('Verifactu', 'No se pudo autenticar: $e');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> refreshInteractions() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;
      backendState.value = await _service.getBackendState();

      if (!(backendState.value?.canUseBackend ?? false)) {
        interactions.clear();
        return;
      }

      interactions.value = await _service.fetchInteractions();
    } catch (e) {
      errorMessage.value = 'No se pudieron cargar las interacciones Verifactu.';
    } finally {
      isLoading.value = false;
    }
  }
}
