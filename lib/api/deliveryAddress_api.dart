// // services/delivery_address_service.dart

// import 'dart:convert';
// import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
// import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
// import 'package:dil_hack_e_commerce/features/auth/model/address.dart';
// import 'package:http/http.dart' as http;

// class DeliveryAddressService {
//   final String baseUrl = AppConstants.BASE_URL;
//   final client = AuthHttpClient(http.Client());

//   Future<Address?> addDeliveryAddress({
//     required String name,
//     required String phone,
//     required String street,
//     required String city,
//     required String pinCode,
//     // required String country,
//   }) async {
//     // Prepare the delivery address object without sending id
//     final deliveryAddress = Address(
//       name: name,
//       phone: phone,
//       street: street,
//       city: city,
//       pinCode: pinCode,
//       // country: country,
//     );

//     // Send POST request
//     final response = await client.post(
//       Uri.parse('$baseUrl/customerApp/deliveryAddress/add'),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: json
//           .encode(deliveryAddress.toJson()), // Convert deliveryAddress to JSON
//     );

//     if (response.statusCode == 200) {
//       return Address.fromJson(
//           json.decode(response.body)); // Parse response JSON
//     } else {
//       throw Exception('Failed to add delivery address');
//     }
//   }

//   // Future<Address?> updateDeliveryAddress(
//   //     Address deliveryAddress) async {
//   //   final response = await client.put(
//   //     Uri.parse(
//   //         '$baseUrl/customerApp/deliveryAddress/update/${deliveryAddress.id}'),
//   //     headers: {
//   //       'Content-Type': 'application/json',
//   //     },
//   //     body: json.encode(deliveryAddress.toJson()),
//   //   );

//   //   if (response.statusCode == 200) {
//   //     return Address.fromJson(json.decode(response.body));
//   //   } else {
//   //     throw Exception('Failed to update delivery address');
//   //   }
//   // }

//   Future<List<Address>?> fetchDeliveryAddresses() async {
//     final response =
//         await client.get(Uri.parse('$baseUrl/customerApp/deliveryAddress/get'));
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonResponse = json.decode(response.body);
//       return jsonResponse
//           .map((address) => Address.fromJson(address))
//           .toList(); // Parse JSON response into a list of DeliveryAddress
//     } else {
//       throw Exception('Failed to fetch delivery addresses');
//     }
//   }
// }
