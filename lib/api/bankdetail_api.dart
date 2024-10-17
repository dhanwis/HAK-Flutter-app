// services/bank_detail_service.dart
import 'dart:convert';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:dil_hack_e_commerce/features/auth/model/bankDetails.dart';
import 'package:http/http.dart' as http;

class BankDetailService {
  final String baseUrl = AppConstants.BASE_URL;
  final client = AuthHttpClient(http.Client());

  Future<BankDetail?> addBankDetail({
    required String accountNumber,
    required String bankName,
    required String ifscCode,
    required String accountHolderName,
  }) async {
    // Prepare the bank detail object without sending id
    final bankDetail = BankDetail(
      accountNumber: accountNumber,
      bankName: bankName,
      ifscCode: ifscCode,
      accountHolderName: accountHolderName,
    );

    // Send POST request
    final response = await client.post(
      Uri.parse('$baseUrl/customerApp/bankdetails/add'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(bankDetail.toJson()), // Convert bankDetail to JSON
    );

    if (response.statusCode == 200) {
      return BankDetail.fromJson(
          json.decode(response.body)); // Parse response JSON
    } else {
      throw Exception('Failed to add bank detail');
    }
  }

  Future<BankDetail?> updateBankDetail(BankDetail bankDetail) async {
    print('her ehe id ${bankDetail.id}');
    final response = await client.put(
      Uri.parse('$baseUrl/customerApp/bankdetails/update/${bankDetail.id}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(bankDetail.toJson()),
    );

    if (response.statusCode == 200) {
      print('updated data ${response.body}');
      return BankDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update bank detail');
    }
  }

  Future<BankDetail?> fetchBankDetails() async {
    final response =
        await client.get(Uri.parse('$baseUrl/customerApp/bankdetails/get'));
    print(response);
    if (response.statusCode == 200) {
      return BankDetail.fromJson(
          json.decode(response.body)); // Parse JSON response
    } else {
      throw Exception('Failed to fetch bank details');
    }
  }
}
