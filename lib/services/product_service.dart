// lib/services/product_service.dart
import 'package:isar/isar.dart';
import '../data/models/product.dart';

class ProductService {
  final Isar _isar;
  ProductService(this._isar);

  Future<void> create(Product product) async {
    await _isar.writeTxn(() async {
      await _isar.products.put(product);
    });
  }

  Future<Product?> getById(int id) async {
    return _isar.products.get(id);
  }

  Future<List<Product>> getAll() async {
    return _isar.products.where().findAll();
  }

  Future<void> update(Product product) async {
    await _isar.writeTxn(() async {
      await _isar.products.put(product);
    });
  }

  Future<void> decrementStock(int productId, int quantity) async {
    final product = await _isar.products.get(productId);
    if (product == null) return;
    product.stock = (product.stock - quantity).clamp(0, 99999);
    await _isar.writeTxn(() async {
      await _isar.products.put(product);
    });
  }

  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      await _isar.products.delete(id);
    });
  }
}
