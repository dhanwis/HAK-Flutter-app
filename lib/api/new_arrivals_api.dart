import 'dart:convert';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:http/http.dart' as http;

class GetAllNewArrivalsApi {
  Future<List<Product>> fetchNewArrivals() async {
    final response = await http.get(
        Uri.parse('http://192.168.1.6:8000/productAdmin/product/new-arrivals'));
    // final response = await http.get(Uri.parse(
    //     'https://hak-server-side.onrender.com/productAdmin/product/new-arrivals'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List productsJson = jsonResponse['data'];
      return productsJson.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception();
    }
  }
}
