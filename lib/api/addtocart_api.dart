import 'dart:convert';

import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:http/http.dart' as http;

class CartService {
  final String baseUrl = AppConstants.BASE_URL;
  final client = AuthHttpClient(http.Client());

  Future<List<dynamic>> fetchCart(String userId) async {
    print('listing al cart');
    final response = await client
        .get(Uri.parse('$baseUrl/customerApp/cart/get_all/$userId'));
    print(response);
    if (response.statusCode == 200) {
      return json.decode(response.body)['products'];
    } else {
      throw Exception('Failed to load cart');
    }
  }

  Future<void> addToCart(String userId, String productId, int quantity) async {
    print('try yo cart');
    final response = await client.post(
      Uri.parse('$baseUrl/customerApp/cart/add/$userId'),
      body: json.encode({'productId': productId, 'quantity': quantity}),
      headers: {'Content-Type': 'application/json'},
    );
    print('print result');
    print(response);
    if (response.statusCode != 201) {
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
    final cartItems = await fetchCart(userId);
    // Check if any item in the cart matches the productId
    return cartItems.any((item) => item['productId'] == productId);
  }
}
