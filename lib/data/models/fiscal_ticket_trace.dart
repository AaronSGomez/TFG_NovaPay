import 'package:isar/isar.dart';

part 'fiscal_ticket_trace.g.dart';

@embedded
class FiscalTicketTraceLine {
  String productName = '';
  int quantity = 0;
  double unitPrice = 0;
  double totalLine = 0;
}

@collection
class FiscalTicketTrace {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String invoiceId;

  late DateTime createdAt;
  String? ticketUuid;
  String? ticketZone;
  int? ticketTableNumber;
  String? ticketTableLabel;
  String? paymentMethod;

  String invoiceSeries = '';
  int invoiceNumber = 0;
  double totalAmount = 0;

  List<FiscalTicketTraceLine> lines = [];
}
