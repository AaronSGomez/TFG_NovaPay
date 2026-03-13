// lib/data/models/ticket.dart
import 'package:isar/isar.dart';
import 'ticket_line.dart';

part 'ticket.g.dart';

enum TicketStatus { abierto, pagado, cancelado }
enum PaymentMethod { efectivo, tarjeta, mixto }

@collection
class Ticket {
  Id id = Isar.autoIncrement;
  late String uuid;

  @Index()
  late DateTime createdAt;

  @Index()
  @enumerated
  TicketStatus status = TicketStatus.abierto;

  @enumerated
  PaymentMethod paymentMethod = PaymentMethod.efectivo;

  double totalAmount = 0;
  int?   tableNumber;
  String? tableOrLabel;

  @Index()
  bool isParked = false;

  String? zone;
  List<TicketLine> lines = [];
}
