import 'dart:convert';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> fetchSearchResults(String query) async {
  if (query.isEmpty) {
    return [];
  }

  // final url = 'http://192.168.1.6:8000/productAdmin/data/search?q=$query';
  final client = AuthHttpClient(http.Client());
  final apiUrl = '${AppConstants.BASE_URL}/customerApp/data/search?q=$query';

  final response = await client.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);

    return body.map((dynamic item) => Product.fromJson(item)).toList();
  } else {
    throw Exception();
  }
}
