class Product {
  final String id;
  final String productId;
  final String productName;
  final String productDescription;
  final double productWeight;
  final String productFeatures;
  final String productPublishDate;
  final String productPublishTime;
  final String productPublishStatus;
  final List<String> productTags;
  final String productType;
  final String productGender;
  final String productBrand;
  final List<Variation> variations;

  Product({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productWeight,
    required this.productFeatures,
    required this.productPublishDate,
    required this.productPublishTime,
    required this.productPublishStatus,
    required this.productTags,
    required this.productType,
    required this.productGender,
    required this.productBrand,
    required this.variations,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<Variation> variationsList = [];
    if (json['variations'] != null) {
      var variationsJson = json['variations'] as List;
      variationsList = variationsJson
          .map((v) => Variation.fromJson(v, json['product_id']))
          .toList();
    }

    return Product(
      id: json['_id'] ?? '',
      productId: json['product_id'] ?? '',
      productName: json['product_name'] ?? '',
      productDescription: json['product_description'] ?? '',
      productWeight: (json['product_weight'] ?? 0).toDouble(),
      productFeatures: json['product_features'] ?? '',
      productPublishDate: json['product_publish_date'] ?? '',
      productPublishTime: json['product_publish_time'] ?? '',
      productPublishStatus: json['product_publish_status'] ?? '',
      productTags: List<String>.from(json['product_tags'] ?? []),
      productType: json['product_type'] ?? '',
      productGender: json['product_gender'] ?? '',
      productBrand: json['product_brand'] ?? '',
      variations: variationsList,
    );
  }
}

class Variation {
  final String id;
  final String color;
  final List<String> images;
  final List<Sku> skus;

  Variation({
    required this.id,
    required this.color,
    required this.images,
    required this.skus,
  });

  factory Variation.fromJson(Map<String, dynamic> json, String productId) {
    const baseUrl = 'http://192.168.1.57:8000/ProductImg/';

    List<String> imagesList = [];
    if (json['images'] != null) {
      var imagesJson = json['images'] as List;
      imagesList = imagesJson.map((v) => '$baseUrl$productId/$v').toList();
    }

    List<Sku> skusList = [];
    if (json['skus'] != null) {
      var skusJson = json['skus'] as List;
      skusList = skusJson.map((v) => Sku.fromJson(v)).toList();
    }

    return Variation(
      id: json['_id'],
      color: json['color'],
      images: imagesList,
      skus: skusList,
    );
  }
}

class Sku {
  final String id;
  final String size;
  final double discount;
  final bool inStock;
  final int quantity;
  final double actualPrice;

  Sku({
    required this.id,
    required this.size,
    required this.discount,
    required this.inStock,
    required this.quantity,
    required this.actualPrice,
  });

  factory Sku.fromJson(Map<String, dynamic> json) {
    return Sku(
      id: json['_id'] ?? '',
      size: json['size'] ?? '',
      discount: (json['discount'] ?? 0).toDouble(),
      inStock: json['in_stock'] ?? false,
      quantity: json['quantity'] ?? 0,
      actualPrice: (json['actualPrice'] ?? 0).toDouble(),
    );
  }
}
