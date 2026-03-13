// lib/services/report_service.dart
import 'package:isar/isar.dart';
import '../data/models/daily_report.dart';
import '../data/models/ticket.dart';

class ReportService {
  final Isar _isar;
  ReportService(this._isar);

  Future<DailyReport> closeDay() async {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day);
    final end   = start.add(const Duration(days: 1));

    final tickets = await _isar.tickets
        .filter()
        .statusEqualTo(TicketStatus.pagado)
        .and()
        .createdAtBetween(start, end)
        .findAll();

    double totalCash = 0;
    double totalCard = 0;
    final Map<String, int> productCount = {};

    for (final ticket in tickets) {
      if (ticket.paymentMethod == PaymentMethod.efectivo) {
        totalCash += ticket.totalAmount;
      } else if (ticket.paymentMethod == PaymentMethod.tarjeta) {
        totalCard += ticket.totalAmount;
      } else {
        totalCash += ticket.totalAmount / 2;
        totalCard += ticket.totalAmount / 2;
      }
      for (final line in ticket.lines) {
        productCount[line.productName] =
            (productCount[line.productName] ?? 0) + line.quantity;
      }
    }

    final summary = productCount.entries
        .map((e) => '${e.key}:${e.value}')
        .toList();

    final report = DailyReport()
      ..date = today
      ..totalCash = totalCash
      ..totalCard = totalCard
      ..grandTotal = totalCash + totalCard
      ..ticketCount = tickets.length
      ..totalExpenses = 0
      ..soldProductsSummary = summary;

    await _isar.writeTxn(() async {
      await _isar.dailyReports.put(report);
    });

    return report;
  }

  Future<DailyReport?> getByDate(DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end   = DateTime(date.year, date.month, date.day, 23, 59, 59);
    return _isar.dailyReports
        .filter()
        .dateBetween(start, end)
        .findFirst();
  }

  Future<List<DailyReport>> getAll() async {
    return _isar.dailyReports
        .where()
        .sortByDateDesc()
        .findAll();
  }

  Future<void> addExpense(double amount) async {
    final report = await getByDate(DateTime.now());
    if (report == null) return;
    report.totalExpenses += amount;
    report.grandTotal =
        report.totalCash + report.totalCard - report.totalExpenses;
    await _isar.writeTxn(() async {
      await _isar.dailyReports.put(report);
    });
  }
}
