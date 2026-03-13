// lib/data/models/ticket_line.dart
import 'package:isar/isar.dart';

part 'ticket_line.g.dart';

@embedded
class TicketLine {
  late String productName;
  int    productId     = 0;
  int    quantity      = 1;
  double priceAtMoment = 0;
  double totalLine     = 0;
}
