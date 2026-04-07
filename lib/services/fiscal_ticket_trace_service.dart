import 'package:isar/isar.dart';

import '../data/models/fiscal_ticket_trace.dart';
import '../data/models/ticket.dart';
import '../data/models/verifactu_models.dart';

class FiscalTicketTraceService {
  final Isar _isar;
  FiscalTicketTraceService(this._isar);

  Future<void> saveEmissionTrace({required Ticket ticket, required BackendInvoiceResponse invoice}) async {
    final existing = await _isar.fiscalTicketTraces.filter().invoiceIdEqualTo(invoice.id).findFirst();
    final trace = existing ?? FiscalTicketTrace();

    trace
      ..invoiceId = invoice.id
      ..createdAt = DateTime.now()
      ..ticketUuid = ticket.uuid
      ..ticketZone = ticket.zone
      ..ticketTableNumber = ticket.tableNumber
      ..ticketTableLabel = ticket.tableOrLabel
      ..paymentMethod = ticket.paymentMethod.name
      ..invoiceSeries = invoice.series
      ..invoiceNumber = invoice.number
      ..totalAmount = ticket.totalAmount
      ..lines = ticket.lines
          .map(
            (line) => FiscalTicketTraceLine()
              ..productName = line.productName
              ..quantity = line.quantity
              ..unitPrice = line.priceAtMoment
              ..totalLine = line.totalLine,
          )
          .toList();

    await _isar.writeTxn(() async {
      await _isar.fiscalTicketTraces.put(trace);
    });
  }

  Future<FiscalTicketTrace?> getByInvoiceId(String invoiceId) async {
    return _isar.fiscalTicketTraces.filter().invoiceIdEqualTo(invoiceId).findFirst();
  }

  Future<Map<String, FiscalTicketTrace>> getByInvoiceIds(Iterable<String> invoiceIds) async {
    final ids = invoiceIds.map((id) => id.trim()).where((id) => id.isNotEmpty).toSet();
    if (ids.isEmpty) {
      return {};
    }

    final traces = await _isar.fiscalTicketTraces.where().findAll();
    final result = <String, FiscalTicketTrace>{};
    for (final trace in traces) {
      if (ids.contains(trace.invoiceId)) {
        result[trace.invoiceId] = trace;
      }
    }
    return result;
  }
}
