import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';

class GetAllProductApi {
  static const String baseUrl =
      'http://192.168.1.6:8000/productAdmin/product/view_all_products';

  Future<List<Product>> fetchProducts({int page = 1}) async {
    final url = '$baseUrl?page=$page&limit=3';
    final response = await http.get(Uri.parse(url));

    print('response itha manjdi');
    print(response);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> productJson =
          data['products']; // Adjust if your API returns data differently
      return productJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
