// lib/presentation/controllers/report_controller.dart
import 'package:get/get.dart';
import '../../data/models/daily_report.dart';
import '../../services/report_service.dart';

class ReportController extends GetxController {
  final ReportService _service;
  ReportController(this._service);

  final reports     = <DailyReport>[].obs;
  final todayReport = Rxn<DailyReport>();
  final isLoading   = false.obs;
  final isClosing   = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAll();
    loadToday();
  }

  Future<void> loadAll() async {
    try {
      isLoading.value = true;
      reports.value = await _service.getAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar los informes');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadToday() async {
    try {
      todayReport.value = await _service.getByDate(DateTime.now());
    } catch (e) {
      Get.snackbar('Error', 'No se pudo cargar el informe de hoy');
    }
  }

  Future<void> closeDay() async {
    try {
      isClosing.value = true;
      final report = await _service.closeDay();
      todayReport.value = report;
      await loadAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo cerrar la jornada');
    } finally {
      isClosing.value = false;
    }
  }

  Future<void> addExpenseToday(double amount) async {
    try {
      await _service.addExpense(amount);
      await loadToday();
      await loadAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo registrar el gasto');
    }
  }

  double get todayCash     => todayReport.value?.totalCash ?? 0;
  double get todayCard     => todayReport.value?.totalCard ?? 0;
  double get todayTotal    => todayReport.value?.grandTotal ?? 0;
  double get todayExpenses => todayReport.value?.totalExpenses ?? 0;
  int    get todayCount    => todayReport.value?.ticketCount ?? 0;

  Map<String, int> get todaySoldProducts {
    final summary = todayReport.value?.soldProductsSummary ?? [];
    final map = <String, int>{};
    for (final entry in summary) {
      final parts = entry.split(':');
      if (parts.length == 2) map[parts[0]] = int.tryParse(parts[1]) ?? 0;
    }
    return map;
  }
}
