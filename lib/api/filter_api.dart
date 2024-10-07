import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FilteredProduct {
  Future<List<Product>> fetchFilteredProducts(
      Map<String, dynamic> filters) async {
    final Uri apiUrl = Uri.parse('https://yourapi.com/products/filter');

    try {
      final response = await http.get(apiUrl.replace(
          queryParameters:
              filters.map((key, value) => MapEntry(key, value.toString()))));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Handle the filtered products data
        final List<dynamic> productJson = data['products'];
        return productJson.map((json) => Product.fromJson(json)).toList();
      } else {
        // Handle error: return an empty list or throw an error
        return []; // Returning an empty list when the status code is not 200
      }
    } catch (error) {
      // Handle exceptions, e.g., network errors
      return []; // Returning an empty list in case of an exception
    }
  }
}
