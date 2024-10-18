import 'dart:convert';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:dil_hack_e_commerce/features/auth/model/order.dart';
import 'package:http/http.dart' as http;

class OrderRepository {
  final String baseUrl = AppConstants.BASE_URL;
  final client = AuthHttpClient(http.Client());

  Future<List<Order>> fetchOrders(String userId) async {
    print('user id $userId');
    final response = await client
        .get(Uri.parse('$baseUrl/customerApp/order/get_all/$userId'));

    print('response $response');

    print(response.body);

    if (response.statusCode == 200) {
      print('yes tru');
      // Decode the response body as a List of orders
      List<dynamic> data = json.decode(response.body)['orders'];

      // Map each item in the list to an Order object
      return data.map((order) => Order.fromJson(order)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<Order> fetchOrderById(String orderId) async {
    final response = await client.get(
      Uri.parse('$baseUrl/customerApp/cart/get_order/$orderId'),
    );

    if (response.statusCode == 200) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load order');
    }
  }

  Future<Order> createOrder(Order order) async {
    final response = await client.post(
      Uri.parse('$baseUrl/customerApp/order/create'),
      headers: {'Content-Type': 'application/json'},
      //body: json.encode(order.toJson()),
    );

    if (response.statusCode == 201) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create order');
    }
  }

  Future<void> updateOrder(String orderId, Order order) async {
    final response = await client.put(
      Uri.parse('$baseUrl/customerApp/order/update/$orderId'),
      headers: {'Content-Type': 'application/json'},
      // body: json.encode(order.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update order');
    }
  }

  Future<void> deleteOrder(String orderId) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/customerApp/order/delete/$orderId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete order');
    }
  }
}
