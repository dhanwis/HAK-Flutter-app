import 'dart:io';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/decodeJwt.dart';
import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewApi {
  String userId = '';
  final String _baseUrl = AppConstants.BASE_URL; // Update with your server URL
  final client = AuthHttpClient(http.Client());

  Future<void> addReview({
    required String productId,
    required double rating,
    required String comment,
    List<File>? images,
  }) async {
    await _initializeUserId();

    try {
      var uri = Uri.parse('$_baseUrl/customerApp/products/$productId/reviews');
      print('URL: $uri');
      print('User ID: $userId');
      var request = http.MultipartRequest('POST', uri);

      // Add fields
      request.fields['userId'] = userId;
      request.fields['rating'] = rating.toString();
      request.fields['comment'] = comment;

      // Add images if available
      if (images != null && images.isNotEmpty) {
        for (var image in images) {
          request.files.add(await http.MultipartFile.fromPath(
            'reviewImg',
            image.path,
          ));
        }
      }

      // Send the request
      var response = await client.send(request);
      var responseData = await http.Response.fromStream(response);
      print("Response Data: ${responseData.body}");

      if (response.statusCode == 201) {
        var jsonResponse = json.decode(responseData.body);
        print("Review added successfully: ${jsonResponse['message']}");
      } else {
        print("Failed to add review: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  Future<void> _initializeUserId() async {
    if (userId.isEmpty) {
      // Ensure that userId is initialized only once
      try {
        final decodedToken =
            await decodeJwt(); // Use your existing decodeJwt method
        userId = decodedToken['userId']; // Assuming userId is part of the token
      } catch (e) {
        throw Exception("Something Wrong to get UserID");
      }
    }
  }
}
