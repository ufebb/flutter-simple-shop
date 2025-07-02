// lib/network/api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart'; // <--- Import Product dari models

class Api {
  final String baseUrl = 'https://dummyjson.com';

  // Fungsi untuk mengambil daftar produk
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey('products')) {
          final List products = data['products'];
          return products.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception('Response tidak memiliki key "products"');
        }
      } else {
        throw Exception('Error dari server: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Terjadi kesalahan: $error');
    }
  }

  // Fungsi untuk mengambil pengguna dari DummyJSON (digunakan untuk login)
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey('users')) {
          final List users = data['users'];
          return users.cast<Map<String, dynamic>>();
        } else {
          throw Exception('Response tidak memiliki key "users"');
        }
      } else {
        throw Exception('Error dari server: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Terjadi kesalahan saat memuat pengguna: $error');
    }
  }

  // Fungsi untuk mengambil detail produk berdasarkan ID
  Future<Product> fetchProductById(int productId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/$productId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data != null) {
          return Product.fromJson(data);
        } else {
          throw Exception('Produk tidak ditemukan');
        }
      } else {
        throw Exception('Error dari server: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Terjadi kesalahan saat memuat produk: $error');
    }
  }
}