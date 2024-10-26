// lib/services/api.dart
import 'dart:convert';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:dil_hack_e_commerce/features/auth/model/userProfile.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/otp_page/tokenStorage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // final tokenStorage = TokenStorage();
  final tokenStorage = TokenStorage();
  final client = AuthHttpClient(http.Client());

  Future<CustomerProfile> createCustomerProfile({
    required String username,
    required String email,
    required String phoneNumber,
    required String pincode,
    required String city,
    required String state,
    String? userImgPath, // Path to the user image
    // required String accessToken, // Add accessToken as a required parameter
  }) async {
    // String? accessToken = await tokenStorage.getAccessToken();

    var uri = Uri.parse(
        '${AppConstants.BASE_URL}/auth_customer/customer/create_profile');

    var request = http.MultipartRequest('POST', uri)
      ..fields['username'] = username
      ..fields['email'] = email
      ..fields['phoneNumber'] = phoneNumber
      ..fields['pincode'] = pincode
      ..fields['city'] = city
      ..fields['state'] = state;

    // Add the authorization header with the Bearer token
    //request.headers['Authorization'] = 'Bearer $accessToken';

    print('making request');
    if (userImgPath != null) {
      request.files
          .add(await http.MultipartFile.fromPath('userImg', userImgPath));
    }

    var response = await client.send(request);
    var responseBody = await response.stream.bytesToString();
    print('resbod body, $responseBody');

    if (response.statusCode == 201) {
      return CustomerProfile.fromJson(jsonDecode(responseBody)['profile']);
    } else {
      throw Exception('Failed to create customer profile');
    }
  }

  Future<CustomerProfile> getProfileData(id) async {
    final response = await client.get(
      Uri.parse(
          '${AppConstants.BASE_URL}/auth_customer/customer/ProfileDataXYZ/$id'),
    );

    if (response.statusCode == 200) {
      print('Data has been passed from server');
      return CustomerProfile.fromJson(
          json.decode(response.body)); // Assuming you have a fromJson method
    } else {
      throw Exception(
          'Failed to load profile data'); // Add a message to the exception
    }
  }
}
