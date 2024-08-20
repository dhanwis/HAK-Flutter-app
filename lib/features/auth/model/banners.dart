import 'package:dil_hack_e_commerce/api/banner_api.dart';

class Banner {
  final String id;
  final String imageUrl;
  final String
      offerType; // 'single_product', 'category_offer', or 'product_list'
  final dynamic
      targetId; // Can be a String (for single ID) or List<String> (for multiple IDs)

  Banner({
    required this.id,
    required this.imageUrl,
    required this.offerType,
    required this.targetId,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    // Check if offer_target is a list or a single string and parse accordingly
    dynamic targetId;
    if (json['offer_target'] is List) {
      targetId = List<String>.from(json['offer_target']);
    } else {
      targetId = json['offer_target'] ?? '';
    }

    return Banner(
      id: json['_id'] ?? '',
      imageUrl: '${BannerService.baseUrl}${json['banner_image']}',
      offerType: json['offer_type'] ?? '',
      targetId: targetId,
    );
  }
}
