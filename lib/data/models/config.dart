// lib/data/models/config.dart
import 'package:isar/isar.dart';

part 'config.g.dart';

@collection
class Config {
  Id id = Isar.autoIncrement;
  String businessMode = 'bar';

  /// Deprecated: usar BusinessConfig.businessName como fuente canónica.
  /// Mantenido solo por compatibilidad con el schema Isar generado.
  String businessName = '';
  String? printerMacAddress;

  // Estado de integración Verifactu backend.
  bool verifactuRegistered = false;
  bool verifactuIsNewSystem = false;
  String? verifactuClientId;
  String? verifactuClientHash;
  DateTime? verifactuLastAuthAt;
}
