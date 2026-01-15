import 'dart:convert';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository({required this.apiService});

  String? _accessToken;
  Map<String, dynamic>? _userData;

  String? get accessToken => _accessToken;
  Map<String, dynamic>? get userData => _userData;

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await apiService.login(email, password);
    _accessToken = response['access_token'];
    _userData = response['user'];
    return response;
  }

  Future<List<Product>> getProducts() async {
    final response = await apiService.getProducts();
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products: ${response.body}');
    }
  }

  Future<void> createProduct(Product product) async {
    // Note: Assuming createProduct in ApiService accepts a Map for Supabase
    await apiService.createProduct(product.toJson());
  }
}
