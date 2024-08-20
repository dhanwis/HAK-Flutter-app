import 'package:dil_hack_e_commerce/api/banner_api.dart';

class Banner {
  final String id;
  final String imageUrl;
  final String offerType;
  final dynamic targetId;

  Banner({
    required this.id,
    required this.imageUrl,
    required this.offerType,
    required this.targetId,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
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
