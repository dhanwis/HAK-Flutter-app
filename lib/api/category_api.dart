import 'dart:convert';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:dil_hack_e_commerce/features/auth/model/categories.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  final client = AuthHttpClient(http.Client());
  Future<List<Category>> fetchCategories() async {
    final response = await client.get(
      Uri.parse('${AppConstants.BASE_URL}/customerApp/category/categories'),
    );

    print('all ctegorues ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('');
    }
  }
}
