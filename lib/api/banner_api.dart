import 'dart:convert';
import 'package:http/http.dart' as http;

class BannerService {
  static const String url =
      'http://192.168.1.31:8000/productAdmin/banner/view_all_banners';
  static const String baseUrl = 'http://192.168.1.31:8000/bannerImg/';

  Future<List<Banner>> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse(url));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> bannerJson = json.decode(response.body);
        return bannerJson.map((json) => Banner.fromJson(json)).toList();
      } else {
        print('Failed to load banners: ${response.reasonPhrase}');
        throw Exception('Failed to load banners');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Error fetching banners');
    }
  }
}

class Banner {
  final String id;
  final String imageUrl;

  Banner({required this.id, required this.imageUrl});

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['_id'] ?? '',
      imageUrl: '${BannerService.baseUrl}${json['imageUrl']}',
    );
  }
}
