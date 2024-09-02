import 'dart:convert';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:http/http.dart' as http;

class GetSimilarProductsApi {
  Future<List<Product>> fetchSimilarProductById(id) async {
    final apiUrl = '${AppConstants.BASE_URL}/customerApp/product/similar/$id';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> productJson = json.decode(response.body);
      return productJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
