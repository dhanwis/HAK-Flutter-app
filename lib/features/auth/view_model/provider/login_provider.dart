// // ignore_for_file: use_build_context_synchronously

// import 'dart:developer';
// import 'package:dil_hack_e_commerce/core/const/snackbar.dart';
// import 'package:dil_hack_e_commerce/features/auth/presentation/otp_page/otp_page.dart';
// import 'package:dil_hack_e_commerce/features/bottom_bar/home_screen.dart';
// import 'package:dil_hack_e_commerce/helpers/animated_routes.dart';
// import 'package:dil_hack_e_commerce/features/auth/model/otp.dart';
// import 'package:dil_hack_e_commerce/secrets/api_links.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class inProvider extends ChangeNotifier {
//   final storage = const FlutterSecureStorage();
//   final dioClient = Dio();
//   String accessToken = '';
//   int id = 0;
//   bool isLoading = false;

//   loginCustomer(String mobileNumber, BuildContext context) async {
//     try {
//       final url = ApiLinks.createUser;
//       isLoading = true;
//       notifyListeners();
//       log('calling api');
//       final response =
//           // sending data to api
//           await dioClient.post(url, data: {'phone_number': mobileNumber});

//       if (response.statusCode == 201) {
//         SnackBars.otpSendBar(context, mobileNumber);
//         id = response.data['id'];
//         isLoading = !isLoading;
//         notifyListeners();

//         // if the otp is send page will navigate to enter otp page

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => EnterOtpPage(
//               mobileNumber: mobileNumber,
//             ),
//           ),
//         );

//         ApiLinks apiLinks = ApiLinks();
//         apiLinks.setId = id;
//       }
//       if (response.statusCode == 500) {
//         log('status 500');
//         log('response : ${response.data}');
//       }
//     } catch (error) {
//       log(
//         error.toString(),
//       );
//     }
//   }

//   submitOtp(String otp, BuildContext context) async {
//     try {
//       final response = await dioClient.patch(
//         'https://hak.pythonanywhere.com/auth/customer/$id/verify-otp/',
//         data: {"otp": otp},
//       );
//       log(otp);
//       if (response.data == 200 || response.statusCode == 201) {
//         SnackBars.otpSuccessBar(context);

//         final tokenData = AuthResponse.fromJson(response.data);
        
//         log(tokenData.access!);

//         Navigator.pushAndRemoveUntil(
//             context,
//             createRoute(HomeScreen(
             
//             )),
//             (route) => false);
//         // log('access token: $accessToken');
//         // log(response.data['refresh']);
//         // log(response.data['access']);
//         // log(response.data['otp']);
//         // log(response.data['message']);
//       }
//     } catch (e) {
//       log(
//         e.toString(),
//       );
//     }
//   }
// }
