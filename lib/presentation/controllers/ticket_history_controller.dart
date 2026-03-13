// lib/presentation/controllers/ticket_history_controller.dart
import 'package:get/get.dart';
import '../../data/models/ticket.dart';
import '../../services/ticket_service.dart';

class TicketHistoryController extends GetxController {
  final TicketService _service;
  TicketHistoryController(this._service);

  final allTickets = <Ticket>[].obs;
  final isLoading  = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAll();
  }

  Future<void> loadAll() async {
    try {
      isLoading.value  = true;
      allTickets.value = await _service.getAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo cargar el historial');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> reopenById(Ticket ticket) async {
    try {
      await _service.reopen(ticket);
      await loadAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo reabrir el ticket');
    }
  }

  Future<void> deleteById(int id) async {
    try {
      await _service.delete(id);
      await loadAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo eliminar el ticket');
    }
  }

  Future<void> changePaymentMethod(Ticket ticket, PaymentMethod method) async {
    try {
      await _service.updatePaymentMethod(ticket, method);
      await loadAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo cambiar el método de pago');
    }
  }
}
