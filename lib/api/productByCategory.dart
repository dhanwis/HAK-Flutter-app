import 'dart:convert';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:http/http.dart' as http;

// class GetProductsByCategory {
//   final client = AuthHttpClient(http.Client());
//   Future<List<Product>> fetchProductByCategoryId(String categoryId,
//       {required Map<String, dynamic> filters}) async {
//     final response = await client.get(Uri.parse(
//         '${AppConstants.BASE_URL}/customerApp/product/category/$categoryId'));

//     print('response');
//     print(response.body);

//     if (response.statusCode == 200) {
//       final List<dynamic> productJson = json.decode(response.body);
//       return productJson.map((json) => Product.fromJson(json)).toList();
//     } else {
//       throw ();
//     }
//   }
// }

class GetProductsByCategory {
  final client = AuthHttpClient(http.Client());
  Future<List<Product>> fetchProductByCategoryId(String categoryId,
      {int page = 1, required Map<String, dynamic> filters}) async {
    final url =
        '${AppConstants.BASE_URL}/customerApp/product/category/$categoryId?page=$page&limit=8';

    final response = await client.get(Uri.parse(url));
    // final response = await client.get(Uri.parse(
    // '${AppConstants.BASE_URL}/customerApp/product/category/$categoryId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> productJson =
          data['products']; // Adjust if your API returns data differently
      return productJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw ();
    }
  }
}



//  required Map<String, dynamic> filters