import 'dart:convert';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://192.168.1.31:8000';

Future<Product> fetchProductById(String productId) async {
  print('id');
  print(productId);

  final response = await http
      .get(Uri.parse('$baseUrl/productAdmin/product/viewProductBy/$productId'));

  print('respnse');
  print(response);

  if (response.statusCode == 200) {
    print('success manji');
    return Product.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load product');
  }
}

Future<List<String>> fetchSimilarProductImages(String productId) async {
  final response = await http
      .get(Uri.parse('$baseUrl/productAdmin/product/similar/$productId'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => item['imageUrl'] as String).toList();
  } else {
    throw Exception('Failed to load similar products');
  }
}
