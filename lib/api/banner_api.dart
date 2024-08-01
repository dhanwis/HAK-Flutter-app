import 'dart:convert';
import 'package:http/http.dart' as http;

class BannerService {
  static const String url =
      'http://192.168.1.11:8000/productAdmin/banner/view_all_banners';
  // 'http://192.168.1.3:8000/productAdmin/banner/view_all_banners'
  // 'https://hak-server-side.onrender.com/productAdmin/banner/view_all_banners';
  static const String baseUrl = 'http://192.168.1.11:8000/bannerImg/';

  // 'https://hak-server-side.onrender.com/bannerImg/';

  Future<List<Banner>> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> bannerJson = json.decode(response.body);
        return bannerJson.map((json) => Banner.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load banners');
      }
    } catch (e) {
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
