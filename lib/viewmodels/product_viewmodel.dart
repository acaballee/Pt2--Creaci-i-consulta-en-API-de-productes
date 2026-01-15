import 'package:flutter/material.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository productRepository;

  ProductViewModel({required this.productRepository});

  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Map<String, dynamic>? get currentUser => productRepository.userData;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await productRepository.login(email, password);
      await fetchProducts();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Error durant el login: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await productRepository.getProducts();
    } catch (e) {
      _errorMessage = 'Error recuperant productes: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addProduct(String name, String description, double price) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newProduct = Product(
        name: name,
        description: description,
        price: price,
      );
      await productRepository.createProduct(newProduct);
      // Refresh list after creation
      await fetchProducts();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Error creant producte: $e';
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _products = [];
    // Ideally we clear repository state too, but keeping simple for now
    notifyListeners();
  }
}
