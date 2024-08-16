import 'package:dil_hack_e_commerce/api/banner_api.dart';

class Banner {
  final String id;
  final String imageUrl;
  final String
      offerType; // Can be 'singleProduct', 'category', or 'productList'
  final String
      targetId; // ID for the target (product ID, category ID, or list ID)

  Banner({
    required this.id,
    required this.imageUrl,
    required this.offerType,
    required this.targetId,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['_id'] ?? '',
      imageUrl: '${BannerService.baseUrl}${json['banner_image']}',
      offerType: json['offer_type'] ?? '',
      targetId: json['offer_target'] ?? '',
    );
  }
}
