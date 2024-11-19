import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_shop/constants.dart';
import 'package:online_shop/product_model.dart';


// services/api_service.dart

class ApiService {
  // Fetch All Products
  Future<List<Product>> fetchAllProducts() async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/products'),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<Product> products = body
            .map((dynamic item) => Product.fromJson(item))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Product>> fetchProductsByCategory(int categoryId) async {
  try {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/categories/$categoryId/products'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Product> products = body
          .map((dynamic item) => Product.fromJson(item))
          .toList();
      return products;
    } else {
      throw Exception('Failed to load products by category');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<Product> fetchProductById(int id) async {
  final response = await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products/$id'));
  if (response.statusCode == 200) {
    return Product.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load product');
  }
}


  // Metode lain tetap sama...
}