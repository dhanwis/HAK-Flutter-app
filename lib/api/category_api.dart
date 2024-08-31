import 'dart:convert';
import 'package:dil_hack_e_commerce/features/auth/model/categories.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  Future<List<Category>> fetchCategories() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.6:8000/productAdmin/category/categories'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
