// lib/presentation/controllers/expense_controller.dart
import 'package:get/get.dart';

import '../../data/models/expense.dart';
import '../../services/expense_service.dart';

class ExpenseController extends GetxController {
  final ExpenseService _service;
  ExpenseController(this._service);

  final todayExpenses = <Expense>[].obs;
  final allExpenses   = <Expense>[].obs;
  final isLoading     = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAll();
    loadToday();
  }

  Future<void> loadToday() async {
    try {
      todayExpenses.value = await _service.getByDate(DateTime.now());
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar los gastos de hoy');
    }
  }

  Future<void> loadAll() async {
    try {
      isLoading.value   = true;
      allExpenses.value = await _service.getAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar los gastos');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addExpense(Expense expense) async {
    try {
      await _service.create(expense);
      await Future.wait([loadToday(), loadAll()]);
    } catch (e) {
      Get.snackbar('Error', 'No se pudo registrar el gasto');
    }
  }

  Future<void> removeExpense(int id) async {
    try {
      await _service.delete(id);
      await Future.wait([loadToday(), loadAll()]);
    } catch (e) {
      Get.snackbar('Error', 'No se pudo eliminar el gasto');
    }
  }

  double get todayTotal =>
      todayExpenses.fold(0.0, (sum, e) => sum + e.amount);

  double totalByCategory(ExpenseCategory cat) => todayExpenses
      .where((e) => e.category == cat)
      .fold(0.0, (sum, e) => sum + e.amount);
}
