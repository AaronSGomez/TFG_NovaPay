// lib/services/user_service.dart
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:isar/isar.dart';
import '../data/models/user.dart';

class UserService {
  final Isar _isar;
  UserService(this._isar);

  // ── Hashing ───────────────────────────────────────────────────────────────

  static String hashPassword(String password) {
    final bytes  = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static bool _isHashed(String password) => password.length == 64;

  // ── CRUD ──────────────────────────────────────────────────────────────────

  Future<void> save(User user) async {
    final pwd = user.password;
    if (pwd != null && !_isHashed(pwd)) {
      user.password = hashPassword(pwd);
    }
    await _isar.writeTxn(() async {
      await _isar.users.put(user);
    });
  }

  Future<User?> getById(int id) async {
    return _isar.users.get(id);
  }

  Future<List<User>> getAll() async {
    return _isar.users.where().findAll();
  }

  Future<User?> login(String identifier, String password) async {
    final hashed = hashPassword(password);

    // Try by email (hashed)
    final byEmail = await _isar.users
        .filter()
        .emailEqualTo(identifier)
        .passwordEqualTo(hashed)
        .findFirst();
    if (byEmail != null) return byEmail;

    // Try by username (hashed)
    final byUsername = await _isar.users
        .filter()
        .usernameEqualTo(identifier)
        .passwordEqualTo(hashed)
        .findFirst();
    if (byUsername != null) return byUsername;

    // Backward-compat: plain-text stored password (upgrades on success)
    User? plain = await _isar.users
        .filter()
        .emailEqualTo(identifier)
        .passwordEqualTo(password)
        .findFirst();
    plain ??= await _isar.users
        .filter()
        .usernameEqualTo(identifier)
        .passwordEqualTo(password)
        .findFirst();

    if (plain != null) {
      plain.password = hashed;
      await _isar.writeTxn(() async => _isar.users.put(plain!));
      return plain;
    }

    return null;
  }

  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      await _isar.users.delete(id);
    });
  }

  Future<void> seedAdmin() async {
    final existing = await _isar.users
        .filter()
        .emailEqualTo('admin')
        .findFirst();
    if (existing != null) {
      bool updated = false;
      if (existing.role != 'admin') {
        existing.role = 'admin';
        updated = true;
      }
      final pwd = existing.password;
      if (pwd != null && !_isHashed(pwd)) {
        existing.password = hashPassword(pwd);
        updated = true;
      }
      if (updated) {
        await _isar.writeTxn(() async => _isar.users.put(existing));
      }
      return;
    }
    final admin = User()
      ..username = 'Admin'
      ..email    = 'admin'
      ..password = hashPassword('1234')
      ..role     = 'admin';
    await _isar.writeTxn(() async {
      await _isar.users.put(admin);
    });
  }
}
