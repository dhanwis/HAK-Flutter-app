// import 'dart:convert';
// import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
// import 'package:http/http.dart' as http;

// const String baseUrl = 'http://192.168.1.6:8000';

// Future<Product> fetchProductById(String productId) async {
//   final response = await http
//       .get(Uri.parse('$baseUrl/productAdmin/product/viewProductBy/$productId'));

//   if (response.statusCode == 200) {
//     return Product.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Failed to load product');
//   }
// }

// Future<List<String>> fetchSimilarProductImages(String productId) async {
//   final response = await http
//       .get(Uri.parse('$baseUrl/productAdmin/product/similar/$productId'));

//   if (response.statusCode == 200) {
//     List<dynamic> data = json.decode(response.body);
//     return data.map((item) => item['imageUrl'] as String).toList();
//   } else {
//     throw Exception('Failed to load similar products');
//   }
// }

import 'dart:convert';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:http/http.dart' as http;

class ProductbyidApi {
  Future<Product> fetchProductById(productId) async {
    final apiUrl =
        'http://192.168.1.6:8000/productAdmin/product/viewProductBy/$productId';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load products');
    }
  }
}
