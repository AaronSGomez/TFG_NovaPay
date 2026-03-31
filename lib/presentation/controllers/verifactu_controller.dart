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
  final subscriptionSummary = Rxn<VerifactuSubscriptionSummary>();
  final adminUser = Rxn<User>();
  final hasActiveJwtSession = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadContext();
    refreshInteractions();
  }

  Future<void> loadContext() async {
    backendState.value = await _service.getBackendState();
    hasActiveJwtSession.value = _service.hasActiveJwtSession;
    adminUser.value = await _userService.getAdmin();
    await _syncAdminBackendLock(backendState.value?.registered ?? false);

    if (backendState.value?.registered ?? false) {
      await refreshSubscriptionSummary(showSnackbarOnError: false);
    } else {
      subscriptionSummary.value = null;
    }
  }

  Future<void> registerBackend({
    required String companyName,
    required String taxId,
    required String address,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String planCode,
    required String billingCycle,
    required bool isNewSystem,
    String? hash,
  }) async {
    try {
      isSubmitting.value = true;
      final normalizedHash = hash?.trim();
      final result = await _service.registerBackendUser(
        companyName: companyName,
        taxId: taxId,
        address: address,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        planCode: planCode,
        billingCycle: billingCycle,
        isNewSystem: isNewSystem,
        clientHash: (normalizedHash == null || normalizedHash.isEmpty) ? null : normalizedHash,
      );
      backendState.value = await _service.getBackendState();
      hasActiveJwtSession.value = _service.hasActiveJwtSession;
      await _syncAdminBackendLock(backendState.value?.registered ?? false);
      await refreshSubscriptionSummary(showSnackbarOnError: false);
      final companySuffix = result.companyId != null ? ' companyId=${result.companyId}' : '';
      final clientSuffix = result.clientId != null ? ' clientId=${result.clientId}' : '';
      final planSuffix = (result.planCode != null && result.billingCycle != null)
          ? ' ${result.planCode}/${result.billingCycle} cuota=${result.baseAmount} limite=${result.invoiceLimit} overage=${result.overagePerInvoice}'
          : '';
      Get.snackbar(
        'Verifactu',
        '${result.message}.$companySuffix$clientSuffix$planSuffix Ahora autentica para activar el backend.',
      );
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
      hasActiveJwtSession.value = _service.hasActiveJwtSession;
      await _syncAdminBackendLock(backendState.value?.registered ?? false);
      await refreshSubscriptionSummary(showSnackbarOnError: false);
      Get.snackbar('Verifactu', 'Autenticación correcta. Backend habilitado por 15 días.');
      await refreshInteractions();
    } catch (e) {
      Get.snackbar('Verifactu', 'No se pudo autenticar: $e');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> authenticateWithCredentials({required String email, required String password}) async {
    try {
      isSubmitting.value = true;
      await _service.authenticateBackendWithCredentials(
        email: email,
        password: password,
        fallbackClientId: adminUser.value?.taxId,
      );
      backendState.value = await _service.getBackendState();
      hasActiveJwtSession.value = _service.hasActiveJwtSession;
      await _syncAdminBackendLock((backendState.value?.registered ?? false) || hasActiveJwtSession.value);
      await refreshSubscriptionSummary(showSnackbarOnError: true);
      Get.snackbar('Verifactu', 'Sesión iniciada correctamente con email y contraseña.');
      await refreshInteractions();
    } catch (e) {
      Get.snackbar('Verifactu', 'No se pudo conectar: $e');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> disconnectBackend() async {
    try {
      isSubmitting.value = true;
      await _service.logoutBackend();
      backendState.value = await _service.getBackendState();
      hasActiveJwtSession.value = _service.hasActiveJwtSession;
      subscriptionSummary.value = null;
      interactions.clear();
      await _syncAdminBackendLock((backendState.value?.registered ?? false) || hasActiveJwtSession.value);
      Get.snackbar('Verifactu', 'Sesión backend cerrada. Puedes reconectar cuando quieras.');
    } catch (e) {
      Get.snackbar('Verifactu', 'No se pudo cerrar la sesión backend: $e');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> changePassword({required String currentPassword, required String newPassword}) async {
    try {
      isSubmitting.value = true;
      await _service.changePassword(currentPassword: currentPassword, newPassword: newPassword);
      hasActiveJwtSession.value = _service.hasActiveJwtSession;
      Get.snackbar('Verifactu', 'Contraseña actualizada. Vuelve a conectar con la nueva contraseña.');
    } catch (e) {
      Get.snackbar('Verifactu', 'No se pudo cambiar contraseña: $e');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> refreshSubscriptionSummary({bool showSnackbarOnError = true}) async {
    try {
      final hasSession = hasActiveJwtSession.value;
      if (!(backendState.value?.registered ?? false) && !hasSession) {
        subscriptionSummary.value = null;
        return;
      }

      subscriptionSummary.value = await _service.fetchSubscriptionSummary();
    } catch (e) {
      if (e is VerifactuApiException && e.statusCode == 404) {
        await _service.resetLocalVerifactuState();
        backendState.value = await _service.getBackendState();
        hasActiveJwtSession.value = _service.hasActiveJwtSession;
        subscriptionSummary.value = null;
        interactions.clear();
        await _syncAdminBackendLock(false);
        if (showSnackbarOnError) {
          Get.snackbar('Verifactu', 'No existe registro backend para este cliente. Se reinició el estado local.');
        }
        return;
      }

      subscriptionSummary.value = null;
      if (showSnackbarOnError) {
        Get.snackbar('Verifactu', 'No se pudo cargar el consumo actual: $e');
      }
    }
  }

  Future<void> refreshInteractions() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;
      backendState.value = await _service.getBackendState();
      hasActiveJwtSession.value = _service.hasActiveJwtSession;

      if (!(backendState.value?.canUseBackend ?? false) && !hasActiveJwtSession.value) {
        interactions.clear();
        await _syncAdminBackendLock((backendState.value?.registered ?? false) || hasActiveJwtSession.value);
        return;
      }

      interactions.value = await _service.fetchInteractions();
      await _syncAdminBackendLock((backendState.value?.registered ?? false) || hasActiveJwtSession.value);
    } catch (e) {
      errorMessage.value = 'No se pudieron cargar las interacciones Verifactu.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetLocalState() async {
    try {
      isSubmitting.value = true;
      await _service.resetLocalVerifactuState();
      backendState.value = await _service.getBackendState();
      hasActiveJwtSession.value = _service.hasActiveJwtSession;
      subscriptionSummary.value = null;
      interactions.clear();
      await _syncAdminBackendLock(false);
      Get.snackbar('Verifactu', 'Estado local reiniciado. Ahora puedes registrar desde cero.');
    } catch (e) {
      Get.snackbar('Verifactu', 'No se pudo reiniciar el estado local: $e');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> requestPasswordRecovery(String email) async {
    if (email.trim().isEmpty) {
      Get.snackbar('Verifactu', 'Indica un email para recuperar contraseña.');
      return;
    }

    try {
      isSubmitting.value = true;
      await _service.requestPasswordRecovery(email: email);
      Get.snackbar('Verifactu', 'Solicitud enviada. Revisa tu email para recuperar contraseña.');
    } catch (e) {
      Get.snackbar('Verifactu', 'No se pudo recuperar contraseña: $e');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> _syncAdminBackendLock(bool lockFields) async {
    final admin = adminUser.value ?? await _userService.getAdmin();
    if (admin == null) {
      return;
    }
    if (admin.backendEditable == lockFields) {
      return;
    }

    admin.backendEditable = lockFields;
    await _userService.save(admin);
    adminUser.value = admin;
  }
}
