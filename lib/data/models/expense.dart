// lib/data/models/expense.dart
import 'package:isar/isar.dart';

part 'expense.g.dart';

enum ExpenseCategory {
  compras,
  facturas,
  personal,
  otro;

  String get label => switch (this) {
        ExpenseCategory.compras  => 'Compras',
        ExpenseCategory.facturas => 'Facturas',
        ExpenseCategory.personal => 'Personal',
        ExpenseCategory.otro     => 'Otro',
      };
}

@collection
class Expense {
  Id id = Isar.autoIncrement;

  late DateTime date;
  late double   amount;

  @enumerated
  ExpenseCategory category = ExpenseCategory.otro;

  String description = '';
  int    productId   = 0;
  String productName = '';
  int    quantity    = 0;
}
