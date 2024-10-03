import 'dart:convert';

import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:dil_hack_e_commerce/features/auth/model/order.dart';
import 'package:http/http.dart' as http;

class OrderRepository {
  final String baseUrl = AppConstants.BASE_URL;
  final client = AuthHttpClient(http.Client());

  Future<List<Order>> fetchOrders(String userId) async {
    final response = await client
        .get(Uri.parse('$baseUrl/customerApp/cart/get_all/$userId'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((order) => Order.fromJson(order)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<void> createOrder(Order order) async {
    // Implement order creation logic
  }
}
