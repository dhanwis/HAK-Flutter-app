import 'dart:developer';

import 'package:dil_hack_e_commerce/features/auth/view/otp_page/otp_page.dart';
import 'package:dil_hack_e_commerce/secrets/api_links.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final dioClient = Dio();
  int id = 0;
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
        id = response.data['id'];
        log(response.data['id'].toString());
        isLoading = false;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EnterOtpPage(),
          ),
        );

        ApiLinks apiLinks = ApiLinks();
        apiLinks.setId = id;

        log('id :$id');
        log(
          response.toString(),
        );
      }
      if(response.statusCode ==500){
        log('status 500');
        log('response : ${response.data}');
      }


    } catch (error) {
      log(
        error.toString(),
      );
    }
  }

  submitOtp(String otp, BuildContext context) async {
    try {
      final response = await dioClient.patch(
        'https://hak.pythonanywhere.com/auth/customer/$id/verify-otp/',
        data: {'otp': otp.toString()},
      );
     
      log(response.data);
    } catch (e) {
      log(
        e.toString(),
      );
    }
  }
}
