import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FilteredProduct {
  Future<List<Product>> fetchFilteredProducts(
      Map<String, dynamic> filters) async {
    try {
      final client = AuthHttpClient(http.Client());

      // Convert filters to a query string
      final queryString = _convertToQueryString(filters);

      final response = await client.get(Uri.parse(
          '${AppConstants.BASE_URL}/customerApp/data/filter/hak?$queryString'));

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

  String _convertToQueryString(Map<String, dynamic> filters) {
    // Filter out null values and convert the map to a query string
    return filters.entries
        .where((entry) => entry.value != null) // Exclude null values
        .map((entry) =>
            '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}')
        .join('&');
  }
}
