import 'package:isar/isar.dart';

import '../data/models/fiscal_ticket_trace.dart';
import '../data/models/ticket.dart';
import '../data/models/verifactu_models.dart';

class FiscalTicketTraceService {
  final Isar _isar;
  FiscalTicketTraceService(this._isar);

  Future<void> saveEmissionTrace({
    required Ticket ticket,
    required BackendInvoiceResponse invoice,
    FiscalStatusResponse? fiscalStatus,
    String? printedFiscalStatus,
    String? printedQrPayload,
    String? queueStatus,
  }) async {
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
      ..queueStatus = queueStatus ?? (invoice.series == 'PEND' ? 'PENDING' : 'FINAL')
      ..printedFiscalStatus = printedFiscalStatus ?? fiscalStatus?.status ?? invoice.status
      ..printedQrPayload = printedQrPayload
      ..fiscalStatus = fiscalStatus?.status ?? invoice.status
      ..secureVerificationCode = fiscalStatus?.secureVerificationCode
      ..verificationUrl = fiscalStatus?.verificationUrl
      ..responseCode = fiscalStatus?.responseCode
      ..responseDescription = fiscalStatus?.responseDescription
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

  Future<List<FiscalTicketTrace>> getPendingProvisionalTraces() async {
    return _isar.fiscalTicketTraces.filter().queueStatusEqualTo('PENDING').findAll();
  }

  Future<void> deleteByInvoiceId(String invoiceId) async {
    final existing = await _isar.fiscalTicketTraces.filter().invoiceIdEqualTo(invoiceId).findFirst();
    if (existing == null) {
      return;
    }

    await _isar.writeTxn(() async {
      await _isar.fiscalTicketTraces.delete(existing.id);
    });
  }

  Future<void> markQueueStatusByInvoiceId(String invoiceId, String queueStatus) async {
    final existing = await _isar.fiscalTicketTraces.filter().invoiceIdEqualTo(invoiceId).findFirst();
    if (existing == null) {
      return;
    }

    existing.queueStatus = queueStatus;
    await _isar.writeTxn(() async {
      await _isar.fiscalTicketTraces.put(existing);
    });
  }

  Future<FiscalTicketTrace?> getByInvoiceId(String invoiceId) async {
    return _isar.fiscalTicketTraces.filter().invoiceIdEqualTo(invoiceId).findFirst();
  }

  Future<FiscalTicketTrace?> getByTicketUuid(String ticketUuid) async {
    return _isar.fiscalTicketTraces.filter().ticketUuidEqualTo(ticketUuid).sortByCreatedAt().findFirst();
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

  Future<List<FiscalTicketTrace>> getAll() async {
    return _isar.fiscalTicketTraces.where().sortByCreatedAtDesc().findAll();
  }

  Future<int> countByQueueStatus(String queueStatus) async {
    return _isar.fiscalTicketTraces.filter().queueStatusEqualTo(queueStatus).count();
  }
}
