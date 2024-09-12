import 'dart:convert';

import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class PaymentPage2 extends StatefulWidget {
  @override
  _PaymentPage2State createState() => _PaymentPage2State();
}

class _PaymentPage2State extends State<PaymentPage2> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Verify payment on the server
    verifyPayment(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment error
    print('Payment failed: ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet selection
    print('External wallet: ${response.walletName}');
  }

  void openCheckout() async {
    var options = {
      'key': 'your-razorpay-key-id',
      'amount': 50000,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '9123456789', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> verifyPayment(PaymentSuccessResponse response) async {
    final client = AuthHttpClient(http.Client());

    final verificationResponse = await client.post(
      Uri.parse('https://your-server/api/payments/verify-payment'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer your-jwt-token',
      },
      body: jsonEncode({
        'razorpay_payment_id': response.paymentId,
        'razorpay_order_id': response.orderId,
        'razorpay_signature': response.signature,
      }),
    );

    if (verificationResponse.statusCode == 200) {
      print('Payment verified successfully');
    } else {
      print('Failed to verify payment: ${verificationResponse.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: openCheckout,
          child: Text('Pay with Razorpay'),
        ),
      ),
    );
  }
}
