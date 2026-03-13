// lib/presentation/controllers/product_controller.dart
import 'package:get/get.dart';
import '../../data/models/product.dart';
import '../../services/product_service.dart';

class ProductController extends GetxController {
  final ProductService _service;
  ProductController(this._service);

  final products         = <Product>[].obs;
  final filtered         = <Product>[].obs;
  final categories       = <String>[].obs;
  final selectedCategory = ''.obs;
  final isLoading        = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAll();
  }

  Future<void> loadAll() async {
    try {
      isLoading.value = true;
      products.value = await _service.getAll();
      _refreshCategories();
      applyFilter(selectedCategory.value);
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar los productos');
    } finally {
      isLoading.value = false;
    }
  }

  void _refreshCategories() {
    final cats = products
        .map((p) => p.category ?? 'Sin categoría')
        .toSet()
        .toList()
      ..sort();
    categories.value = ['Todos', ...cats];
  }

  void applyFilter(String category) {
    selectedCategory.value = category;
    if (category.isEmpty || category == 'Todos') {
      filtered.value = products.toList();
    } else {
      filtered.value = products
          .where((p) => (p.category ?? 'Sin categoría') == category)
          .toList();
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      applyFilter(selectedCategory.value);
      return;
    }
    filtered.value = products
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> create(Product product) async {
    try {
      await _service.create(product);
      await loadAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo crear el producto');
    }
  }

  Future<void> saveProduct(Product product) async {
    try {
      await _service.update(product);
      await loadAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo actualizar el producto');
    }
  }

  Future<void> remove(int id) async {
    try {
      await _service.delete(id);
      await loadAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo eliminar el producto');
    }
  }

  Future<void> decrement(int productId, int quantity) async {
    try {
      await _service.decrementStock(productId, quantity);
      await loadAll();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo actualizar el stock');
    }
  }
}
