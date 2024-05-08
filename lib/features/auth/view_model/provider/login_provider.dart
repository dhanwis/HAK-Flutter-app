import 'dart:developer';

import 'package:dil_hack_e_commerce/features/auth/view/otp_page/otp_page.dart';
import 'package:dil_hack_e_commerce/secrets/api_links.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final dioClient = Dio();

  bool isLoading = false;

  loginCustomer(String mobileNumber, BuildContext context) async {
    try {
      final url = ApiLinks.createUser;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sending Otp'),
        ),
      );
      isLoading = true;
      notifyListeners();

      log('calling api');
      final response =
          // sending data to api
          await dioClient.post(url, data: {'phone_number': mobileNumber});

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EnterOtpPage(),
          ),
        );
        log(
          response.toString(),
        );
      }
    } catch (error) {
      log(
        error.toString(),
      );
    }
  }
}
