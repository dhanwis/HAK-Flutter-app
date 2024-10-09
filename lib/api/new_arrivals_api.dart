import 'dart:convert';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:http/http.dart' as http;

class GetAllNewArrivalsApi {
  final client = AuthHttpClient(http.Client());
  Future<List<Product>> fetchNewArrivals() async {
    final response = await client.get(
        Uri.parse('${AppConstants.BASE_URL}/customerApp/product/new-arrivals'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List productsJson = jsonResponse;
      return productsJson.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception();
    }
  }
}
