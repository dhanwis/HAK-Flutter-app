import 'dart:convert';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:http/http.dart' as http;

class GetProductListByOffer {
  Future<List<Product>> fetchProductsByIds(List<String> productIds) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.6:8000/productAdmin/product/offeredProducts?ids=${productIds.join(",")}'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception();
    }
  }
}
