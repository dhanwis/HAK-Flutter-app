import 'dart:convert';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:http/http.dart' as http;
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';

class GetAllProductApi {
  // static const String baseUrl = 'productAdmin/product/view_all_products';

  Future<List<Product>> fetchProducts({int page = 1}) async {
    final url =
        '${AppConstants.BASE_URL}/customerApp/product/view_all_products?page=$page&limit=10';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> productJson =
          data['products']; // Adjust if your API returns data differently
      return productJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
