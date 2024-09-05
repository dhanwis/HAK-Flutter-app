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
    required String userImgPath, // Path to the user image
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

    if (userImgPath.isNotEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath('userImg', userImgPath));
    }

    var response = await client.send(request);
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return CustomerProfile.fromJson(jsonDecode(responseBody)['profile']);
    } else {
      throw Exception('Failed to create customer profile');
    }
  }

  // Future<CustomerProfile> updateCustomerProfile({
  //   required String id,
  //   String? username,
  //   String? email,
  //   String? phoneNumber,
  //   String? pincode,
  //   String? city,
  //   String? state,
  //   String? userImgPath,
  // }) async {
  //   var uri = Uri.parse('${AppConstants.BASE_URL}/customer_profile_update/$id');
  //   var request = http.MultipartRequest('PUT', uri);

  //   if (username != null) request.fields['username'] = username;
  //   if (email != null) request.fields['email'] = email;
  //   if (phoneNumber != null) request.fields['phoneNumber'] = phoneNumber;
  //   if (pincode != null) request.fields['pincode'] = pincode;
  //   if (city != null) request.fields['city'] = city;
  //   if (state != null) request.fields['state'] = state;

  //   if (userImgPath != null) {
  //     request.files
  //         .add(await http.MultipartFile.fromPath('userImg', userImgPath));
  //   }

  //   var response = await request.send();
  //   var responseBody = await response.stream.bytesToString();

  //   if (response.statusCode == 200) {
  //     return CustomerProfile.fromJson(jsonDecode(responseBody)['profile']);
  //   } else {
  //     throw Exception('Failed to update customer profile');
  //   }
  // }

  // Future<void> deleteCustomerProfile(String id) async {
  //   var uri = Uri.parse('${AppConstants.BASE_URL}/customer_profile_delete/$id');
  //   var response = await http.delete(uri);

  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to delete customer profile');
  //   }
  // }

  Future<CustomerProfile> getProfileData(id) async {
    final response = await client.get(
      Uri.parse(
          '${AppConstants.BASE_URL}/auth_customer/customer/ProfileDataXYZ/$id'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('user dataaaaa');
      print(data);
      return CustomerProfile.fromJson(json.decode(response.body));
    } else {
      throw Exception();
    }
  }
}
