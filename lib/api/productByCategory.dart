import 'dart:convert';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:http/http.dart' as http;

class GetProductsByCategory {
  Future<List<Product>> fetchProductByCategoryId(String categoryId,
      {required Map<String, dynamic> filters}) async {
    const String baseUrl = 'http://192.168.1.6:8000';
    final response = await http
        .get(Uri.parse('$baseUrl/productAdmin/product/category/$categoryId'));

    if (response.statusCode == 200) {
      final List<dynamic> productJson = json.decode(response.body);
      return productJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw ();
    }
  }
}
