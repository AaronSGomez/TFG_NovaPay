import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../data/models/daily_report.dart';
import '../data/models/ticket.dart';
import 'report_service.dart';
import 'ticket_service.dart';

class ExportService {
  final ReportService _reportService;
  final TicketService _ticketService;

  ExportService(this._reportService, this._ticketService);

  /// Exporta todos los tickets y cierres diarios a un archivo JSON
  Future<String> exportToJson() async {
    try {
      print('📦 Iniciando exportación de TODOS los datos...');
      final tickets = await _ticketService.getAll();
      final reports = await _reportService.getAll();

      print('✓ Encontrados ${tickets.length} tickets y ${reports.length} cierres');

      // Estructura clara del JSON
      final data = {
        'exportDate': DateTime.now().toIso8601String(),
        'summary': {'totalTickets': tickets.length, 'totalReports': reports.length},
        'tickets': _formatTickets(tickets),
        'dailyReports': _formatReports(reports),
      };

      // Convertir a JSON con formato legible
      final jsonString = jsonEncode(data);
      print('✓ JSON generado: ${jsonString.length} caracteres');

      // Guardar en archivo
      final fileName = 'novapay_export_${DateTime.now().millisecondsSinceEpoch}.json';
      final file = await _saveFile(fileName, jsonString);

      print('✓ Exportación completada: ${file.path}');
      return file.path;
    } catch (e) {
      print('✗ Error en exportToJson: $e');
      throw Exception('Error exportando datos: $e');
    }
  }

  /// Exporta tickets y cierres de un periodo [startInclusive, endExclusive).
  Future<String> exportPeriodToJson({
    required DateTime startInclusive,
    required DateTime endExclusive,
    required String periodLabel,
    required String fileTag,
  }) async {
    try {
      print('📦 Iniciando exportación de periodo: $periodLabel');

      final allTickets = await _ticketService.getAll();
      final allReports = await _reportService.getAll();

      final tickets = allTickets
          .where((t) => !t.createdAt.isBefore(startInclusive) && t.createdAt.isBefore(endExclusive))
          .toList();

      final reports = allReports
          .where((r) => !r.date.isBefore(startInclusive) && r.date.isBefore(endExclusive))
          .toList();

      final paidTickets = tickets.where((t) => t.status == TicketStatus.pagado).toList();
      final totalExpenses = reports.fold(0.0, (sum, r) => sum + r.totalExpenses);

      final data = {
        'exportDate': DateTime.now().toIso8601String(),
        'period': {
          'label': periodLabel,
          'startInclusive': startInclusive.toIso8601String(),
          'endExclusive': endExclusive.toIso8601String(),
        },
        'summary': {
          'ticketsCount': tickets.length,
          'paidTickets': paidTickets.length,
          'totalIncome': _sumTicketAmounts(paidTickets),
          'totalExpenses': totalExpenses,
          'reportsCount': reports.length,
        },
        'tickets': _formatTickets(tickets),
        'dailyReports': _formatReports(reports),
      };

      final jsonString = jsonEncode(data);
      print('✓ JSON de periodo generado: ${jsonString.length} caracteres');

      final fileName = 'novapay_period_${fileTag}_${DateTime.now().millisecondsSinceEpoch}.json';
      final file = await _saveFile(fileName, jsonString);
      print('✓ Exportación de periodo completada: ${file.path}');
      return file.path;
    } catch (e) {
      print('✗ Error en exportPeriodToJson: $e');
      throw Exception('Error exportando periodo: $e');
    }
  }

  /// Exporta solo los tickets y cierres del día actual
  Future<String> exportTodayToJson() async {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day);
    final endExclusive = start.add(const Duration(days: 1));
    final tag = '${today.year}${today.month.toString().padLeft(2, '0')}${today.day.toString().padLeft(2, '0')}';

    return exportPeriodToJson(
      startInclusive: start,
      endExclusive: endExclusive,
      periodLabel: 'Día ${today.toIso8601String().split('T')[0]}',
      fileTag: 'day_$tag',
    );
  }

  /// Exporta tickets y cierres del mes completo indicado.
  Future<String> exportMonthToJson(DateTime monthDate) async {
    final start = DateTime(monthDate.year, monthDate.month, 1);
    final endExclusive = DateTime(monthDate.year, monthDate.month + 1, 1);
    final monthTag = '${monthDate.year}${monthDate.month.toString().padLeft(2, '0')}';

    return exportPeriodToJson(
      startInclusive: start,
      endExclusive: endExclusive,
      periodLabel: 'Mes ${monthDate.month.toString().padLeft(2, '0')}/${monthDate.year}',
      fileTag: 'month_$monthTag',
    );
  }

  /// Formatea lista de tickets para JSON
  List<Map<String, dynamic>> _formatTickets(List<Ticket> tickets) {
    return tickets.map((t) {
      return {
        'id': t.uuid,
        'createdAt': t.createdAt.toIso8601String(),
        'status': _ticketStatusToString(t.status),
        'paymentMethod': _paymentMethodToString(t.paymentMethod),
        'totalAmount': t.totalAmount,
        'tableNumber': t.tableNumber,
        'tableLabel': t.tableOrLabel,
        'zone': t.zone,
        'isParked': t.isParked,
        'items': t.lines
            .map(
              (line) => {
                'product': line.productName,
                'quantity': line.quantity,
                'price': line.priceAtMoment,
                'total': line.totalLine,
              },
            )
            .toList(),
      };
    }).toList();
  }

  /// Formatea un reporte diario para JSON
  Map<String, dynamic> _formatSingleReport(DailyReport report) {
    return {
      'date': report.date.toIso8601String().split('T')[0],
      'totalCash': report.totalCash,
      'totalCard': report.totalCard,
      'grandTotal': report.grandTotal,
      'ticketCount': report.ticketCount,
      'totalExpenses': report.totalExpenses,
      'soldProducts': report.soldProductsSummary,
    };
  }

  /// Formatea lista de reportes para JSON
  List<Map<String, dynamic>> _formatReports(List<DailyReport> reports) {
    return reports.map((r) => _formatSingleReport(r)).toList();
  }

  /// Suma los montos de los tickets
  double _sumTicketAmounts(List<Ticket> tickets) {
    return tickets.fold(0.0, (sum, t) => sum + t.totalAmount);
  }

  /// Convierte TicketStatus a string
  String _ticketStatusToString(TicketStatus status) {
    return status.toString().split('.').last;
  }

  /// Convierte PaymentMethod a string
  String _paymentMethodToString(PaymentMethod method) {
    return method.toString().split('.').last;
  }

  /// Guarda el contenido en un archivo
  Future<File> _saveFile(String fileName, String content) async {
    try {
      // Obtener el directorio apropiado según la plataforma
      Directory directory;

      if (kIsWeb) {
        // En web, usar el directorio actual (aunque el navegador lo manejará diferente)
        directory = Directory.current;
      } else if (Platform.isAndroid || Platform.isIOS) {
        // En móvil, usar documentos de la aplicación
        directory = await getApplicationDocumentsDirectory();
      } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        // En desktop, usar documentos de la aplicación
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      // Construir el path usando path.join para multiplataforma
      final filePath = p.join(directory.path, fileName);

      // Crear el archivo y escribir el contenido
      final file = File(filePath);
      final savedFile = await file.writeAsString(content);

      print('✓ Archivo guardado en: $filePath');
      return savedFile;
    } catch (e) {
      print('✗ Error guardando archivo: $e');
      throw Exception('Error guardando archivo: $e');
    }
  }
}
