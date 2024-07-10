import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchSimilarProductImages(String productId) async {
  final apiUrl =
      'http://192.168.1.31:8000/productAdmin/product/similar/$productId';

  final response = await http.get(Uri.parse(apiUrl));

  print('Fetching similar product images for product ID: $productId');

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    // Extract image URLs from the response
    List<String> imageUrls = [];
    for (var product in data) {
      if (product['variations'].isNotEmpty) {
        var firstVariation = product['variations'][0];
        if (firstVariation['images'].isNotEmpty) {
          var firstImage = firstVariation['images'][0];
          final productId = product['product_id'];
          final imageUrl =
              'http://192.168.1.31:8000/ProductImg/$productId/$firstImage';
          imageUrls.add(imageUrl);
          print('Added image URL: $imageUrl');
        }
      }
    }
    return imageUrls;
  } else {
    print(
        'Failed to load similar products with status: ${response.statusCode}');
    throw Exception('Failed to load similar products');
  }
}
