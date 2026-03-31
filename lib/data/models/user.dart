// lib/data/models/user.dart
import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;
  String? username;
  String? lastName;
  String? password;

  @Index(unique: true, name: 'email_index')
  String? email;

  String? phone;

  // 'admin' o 'user'
  String role = 'user';

  // Campos de empresa
  String? companyName;
  String? taxId; // CIF/NIF (razón social)
  String? address; // Dirección
  String? logoPath; // Ruta a imagen del logo

  // Controla si estos campos son editables desde el frontend
  // true = solo lectura (bloqueado por backend)
  // false = editable (default)
  bool backendEditable = false;
}
