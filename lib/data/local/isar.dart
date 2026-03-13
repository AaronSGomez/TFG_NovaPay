// lib/data/local/isar.dart
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/models/user.dart';
import '../../data/models/product.dart';
import '../../data/models/ticket.dart';
import '../../data/models/daily_report.dart';
import '../../data/models/config.dart';
import '../../data/models/business_config.dart';
import '../../data/models/expense.dart';

Future<Isar> openIsar() async {
  if (Isar.instanceNames.isNotEmpty) {
    return Isar.getInstance()!;
  }
  final dir = await getApplicationDocumentsDirectory();
  return await Isar.open(
    [
      UserSchema,
      ProductSchema,
      TicketSchema,
      DailyReportSchema,
      ConfigSchema,
      BusinessConfigSchema,
      ExpenseSchema,
    ],
    directory: dir.path,
  );
}