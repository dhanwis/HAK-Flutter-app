import 'dart:convert';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:http/http.dart' as http;

class GetProductsByCategory {
  Future<List<Product>> fetchProductByCategoryId(String categoryId,
      {required Map<String, dynamic> filters}) async {
    final response = await http.get(Uri.parse(
        '${AppConstants.BASE_URL}/customerApp/product/category/$categoryId'));

    print('response');
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> productJson = json.decode(response.body);
      return productJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw ();
    }
  }
}
