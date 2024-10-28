import 'dart:convert';

import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:http/http.dart' as http;

class CartService {
  final String baseUrl = AppConstants.BASE_URL;
  final client = AuthHttpClient(http.Client());

  Future<List<dynamic>> fetchCart(String userId) async {
    final response = await client
        .get(Uri.parse('$baseUrl/customerApp/cart/get_all/$userId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      // Assuming your items are under "cartItems"
      return decodedResponse['items'];
    } else if (response.statusCode == 400) {
      final decodedResponse = json.decode(response.body);
      if (decodedResponse['message'] == "This product is already in the cart") {
        throw Exception(decodedResponse['message']);
      }
    }

    throw Exception('Failed to load cart');
  }

  Future<Map<String, dynamic>> addToCart(
      String userId, String productId, int quantity) async {
    final response = await client.post(
      Uri.parse('$baseUrl/customerApp/cart/add/$userId'),
      body: json.encode({'productId': productId, 'quantity': quantity}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      // Return the decoded response body (assuming it contains a map)
      return json.decode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 400) {
      // Return a specific map indicating the product is already in the cart
      return {'message': 'This product is already in the cart'};
    } else {
      throw Exception('Failed to add to cart');
    }
  }

  Future<void> removeFromCart(String userId, String productId) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/customerApp/cart/delete/$userId/$productId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove from cart');
    }
  }

  Future<void> updateCart(String userId, String productId, int quantity) async {
    final response = await client.patch(
      Uri.parse('$baseUrl/customerApp/cart/update/$userId/$productId'),
      body: json.encode({'quantity': quantity}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update cart');
    }
  }

  /// Check if a product is in the user's cart
  Future<bool> isProductInCart(String userId, String productId) async {
    // Fetch the entire cart as a List<Map<String, dynamic>>
    final List cartItems = await fetchCart(userId);

    // Check if any item in the cart matches the productId
    return cartItems.any((item) => item['product']['_id'] == productId);
  }
}
