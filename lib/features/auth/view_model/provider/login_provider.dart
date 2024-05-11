// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/auth/view/otp_page/otp_page.dart';
import 'package:dil_hack_e_commerce/secrets/api_links.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  final dioClient = Dio();
  String accessToken = '';
  int id = 0;
  bool isLoading = false;

  loginCustomer(String mobileNumber, BuildContext context) async {
    try {
      final url = ApiLinks.createUser;

      IconSnackBar.show(
          snackBarStyle:
              const SnackBarStyle(backgroundColor: Palette.textFormBorder),
          context,
          label: 'Sending OTP to $mobileNumber',
          snackBarType: SnackBarType.success);

      isLoading = true;
      notifyListeners();
      log('calling api');
      final response =
          // sending data to api
          await dioClient.post(url, data: {'phone_number': mobileNumber});

      if (response.statusCode == 201) {
        id = response.data['id'];
        log(response.data['id'].toString());
        log(isLoading.toString());

        isLoading = !isLoading;
        notifyListeners();
        log(isLoading.toString());

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EnterOtpPage(
              mobileNumber: mobileNumber,
            ),
          ),
        );

        ApiLinks apiLinks = ApiLinks();
        apiLinks.setId = id;

        log('id :$id');
        log(
          response.toString(),
        );
      }
      if (response.statusCode == 500) {
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
    final sharedPreferences = await SharedPreferences.getInstance();
    try {
      final response = await dioClient.patch(
        'https://hak.pythonanywhere.com/auth/customer/$id/verify-otp/',
        data: {"otp": otp},
      );
      log(otp);
      if (response.data == 200 || response.statusCode == 201) {
        IconSnackBar.show(
            snackBarStyle:
                const SnackBarStyle(backgroundColor: Palette.textFormBorder),
            context,
            label: 'Successfully Verified OTP',
            snackBarType: SnackBarType.success);
        // await sharedPreferences.setString(
        //     'access_token', response.data['access'].toString());
        //     accessToken = await sharedPreferences.getString('access_token').toString();
        log('access token: $accessToken');
        log(response.data['refresh']);
        log(response.data['access']);
        log(response.data['otp']);
        log(response.data['message']);
      }
    } catch (e) {
      log(
        e.toString(),
      );
    }
  }
}
