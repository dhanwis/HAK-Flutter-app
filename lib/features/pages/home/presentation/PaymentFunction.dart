import 'dart:convert';

import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class Paymentfunction {
  final client = AuthHttpClient(http.Client());

  Future<void> startPayment(double totalAmount) async {
    // Call the backend to create a Razorpay order
    var response = await client.post(
      Uri.parse('${AppConstants.BASE_URL}/customerApp/payment/create'),
      body: jsonEncode({'amount': totalAmount}),
      headers: {'Content-Type': 'application/json'},
    );

    var orderData = jsonDecode(response.body);

    var options = {
      'key': 'your_razorpay_key',
      'amount': (totalAmount * 100).toInt(), // Convert to paise
      'name': 'Your Store',
      'description': 'Order Payment',
      'order_id': orderData['id'], // Use the order ID from backend
      'prefill': {
        'contact': '1234567890',
        'email': 'customer@example.com',
      },
      'theme': {
        'color': '#F37254',
      },
    };

    Razorpay razorpay = Razorpay();
    razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    var verifyPaymentData = {
      'paymentId': response.paymentId,
      'orderId': response.orderId,
      'signature': response.signature,
    };

    var serverResponse = await http.post(
      Uri.parse('http://your-server.com/api/verify-payment'),
      body: jsonEncode(verifyPaymentData),
      headers: {'Content-Type': 'application/json'},
    );

    if (serverResponse.statusCode == 200) {
      // Payment verified and order placed
      print('Order placed successfully');
    } else {
      print('Payment verification failed');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle the error
    print('Payment failed: ${response.message}');
  }
}
