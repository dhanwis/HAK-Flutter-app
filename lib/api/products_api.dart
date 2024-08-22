import 'dart:convert';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:http/http.dart' as http;

class GetAllProductApi {
  static const String url =
      'http://192.168.1.6:8000/productAdmin/product/view_all_products';
  // 'https://hak-server-side.onrender.com/productAdmin/product/view_all_products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> productJson = json.decode(response.body);
      return productJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
