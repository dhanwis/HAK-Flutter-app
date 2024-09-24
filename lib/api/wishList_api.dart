import 'dart:convert';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:http/http.dart' as http;

class WishlistService {
  final String baseUrl = AppConstants.BASE_URL;
  final client = AuthHttpClient(http.Client());

  Future<List<dynamic>> fetchWishlist(String userId) async {
    print(userId);
    print('checking on connection');
    final response = await client
        .get(Uri.parse('$baseUrl/customerApp/whishList/get_all/$userId'));
    if (response.statusCode == 200) {
      print('all ${response.body}');
      return json.decode(response.body)['products'];
    } else {
      throw Exception('Failed to load wishlist');
    }
  }

  Future<void> addToWishlist(String userId, String productId) async {
    print('acllnig');
    final response = await client.post(
      Uri.parse('$baseUrl/customerApp/whishList/add/$userId'),
      body: json.encode({'productId': productId}),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
    if (response.statusCode != 201) {
      throw Exception('Failed to add to wishlist');
    }
  }

  Future<void> removeFromWishlist(String userId, String productId) async {
    final response = await client.delete(
        Uri.parse('$baseUrl/customerApp/wishList/delete/$userId/$productId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to remove from wishlist');
    }
  }
}
