import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://itvyvvxonnsdoqokvikw.supabase.co';
  static const String _anonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0dnl2dnhvbm5zZG9xb2t2aWt3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU0ODE1NTQsImV4cCI6MjA4MTA1NzU1NH0.6AxDj1flnnqtBvOjoKe9_MehqBwo0kNgxLGOf4VKQ5A';

  // Capçaleres base obligatòries per a Supabase
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'apikey': _anonKey,
    // 'Authorization': 'Bearer $token' // Aquí s'hauria d'afegir el token un cop loguejat per a peticions privades
  };

  // Funció per fer Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/v1/token?grant_type=password');
    
    try {
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Login correcte
        return jsonDecode(response.body);
      } else {
        // Error (credencials incorrectes, etc.)
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['error_description'] ?? 'Error desconegut al login');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Exemple de com seria una petició GET de productes (segons les instruccions)
  Future<http.Response> getProducts() async {
     // Nota: per llegir taules, l'endpoint és /rest/v1/nom_taula
     final url = Uri.parse('$_baseUrl/rest/v1/products?select=*'); 
     return await http.get(url, headers: _headers);
  }

  // Exemple per crear producte amb les capçaleres específiques que demanen
  Future<void> createProduct(Map<String, dynamic> productData) async {
    final url = Uri.parse('$_baseUrl/rest/v1/products');
    
    final customHeaders = {
      ..._headers,
      'Prefer': 'return=representation', // Perquè retorni les dades
      'Accept': 'application/vnd.pgrst.object+json', // Perquè no retorni una llista
      // 'Authorization': 'Bearer ...' // Necessitaràs el token obtingut al login
    };

    await http.post(url, headers: customHeaders, body: jsonEncode(productData));
  }
}