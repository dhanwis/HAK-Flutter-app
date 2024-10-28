import 'package:dil_hack_e_commerce/constants/baseUrl.dart';

class Product {
  final String id;
  final String productId;
  final String productName;
  final String productDescription;
  final double productWeight;
  final String productFeatures;
  final String productPublishDate;
  final DateTime productPublishDatetime;
  final String productPublishStatus;
  final List<String> productTags;
  final String productType;
  final String productGender;
  final String productBrand;
  String? averageRating;

  final List<Variation> variations;

  //this below was demmy
  //final double rating;
  //final int reviewCount;

  Product({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productWeight,
    required this.productFeatures,
    required this.productPublishDate,
    required this.productPublishDatetime,
    required this.productPublishStatus,
    required this.productTags,
    required this.productType,
    required this.productGender,
    required this.productBrand,
    this.averageRating,
    required this.variations,

    //this below was demmy
    //required this.rating,
    //required this.reviewCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Debug print to see the raw JSON data

    List<Variation> variationsList = [];
    if (json['variations'] != null) {
      var variationsJson = json['variations'] as List;
      variationsList = variationsJson
          .map((v) => Variation.fromJson(v, json['product_id'] ?? ''))
          .toList();
    }

    return Product(
      id: json['_id']?.toString() ?? '',
      productId: json['product_id']?.toString() ?? '',
      productName: json['product_name']?.toString() ?? '',
      productDescription: json['product_description']?.toString() ?? '',
      productWeight: (json['product_weight'] is int)
          ? (json['product_weight'] as int).toDouble()
          : (json['product_weight'] is double)
              ? json['product_weight']
              : 0.0,
      productFeatures: json['product_features']?.toString() ?? '',
      productPublishDate: json['product_publish_date']?.toString() ?? '',
      productPublishDatetime: DateTime.tryParse(
              json['product_publish_datetime']?.toString() ?? '') ??
          DateTime(1970),
      productPublishStatus: json['product_publish_status']?.toString() ?? '',
      productTags: (json['product_tags'] is List)
          ? List<String>.from(json['product_tags'])
          : [],
      productType: json['product_type']?.toString() ?? '',
      productGender: json['product_gender']?.toString() ?? '',
      productBrand: json['product_brand']?.toString() ?? '',
      averageRating: json['averageRating']?.toString() ?? '',
      // rating: 4.0,
      // reviewCount: 1200,
      variations: variationsList,
    );
  }

  get similarProducts => null;

  //static fromModel(ProductsModel model) {}
}

class Variation {
  final String id;
  // final String color;
  final ColorSchema color; // Update this line
  final List<String> images;
  final List<Sku> skus;

  Variation({
    required this.id,
    required this.color,
    required this.images,
    required this.skus,
  });

  factory Variation.fromJson(Map<String, dynamic> json, String productId) {
    List<String> imagesList = [];
    if (json['images'] != null) {
      var imagesJson = json['images'] as List;
      imagesList = imagesJson
          .map((v) => '${AppConstants.PRODUCT_IMG}/$productId/$v')
          .toList();
    }

    List<Sku> skusList = [];
    if (json['skus'] != null) {
      var skusJson = json['skus'] as List;
      skusList = skusJson.map((v) => Sku.fromJson(v)).toList();
    }

    // Check if 'color' is a Map or String, and handle accordingly
    ColorSchema colorSchema;
    if (json['color'] is Map<String, dynamic>) {
      colorSchema = ColorSchema.fromJson(json['color']);
    } else if (json['color'] is String) {
      // If 'color' is a String, you can either parse it or create a default ColorSchema object
      // Assuming you just want to create a default ColorSchema
      colorSchema = ColorSchema(
        id: '',
        value: json['color'],
        label: json['color'],
        colorCode: '',
      );
    } else {
      // If 'color' is null or any other type, create a default ColorSchema object
      colorSchema = ColorSchema(
        id: '',
        value: '',
        label: '',
        colorCode: '',
      );
    }

    return Variation(
      id: json['_id']?.toString() ?? '',
      color: colorSchema, // Use the updated ColorSchema object
      images: imagesList,
      skus: skusList,
    );
  }
}

class ColorSchema {
  final String id;
  final String value;
  final String label;
  final String colorCode;

  ColorSchema({
    required this.id,
    required this.value,
    required this.label,
    required this.colorCode,
  });

  factory ColorSchema.fromJson(Map<String, dynamic> json) {
    return ColorSchema(
      id: json['_id']?.toString() ?? '',
      value: json['value']?.toString() ?? '',
      label: json['label']?.toString() ?? '',
      colorCode: json['colorCode']?.toString() ?? '',
    );
  }
}

class Sku {
  final String size;
  final int discount;
  final bool inStock;
  final int quantity;
  final double actualPrice;
  final double discountedPrice;
  final String id;

  Sku({
    required this.size,
    required this.discount,
    required this.inStock,
    required this.quantity,
    required this.actualPrice,
    required this.discountedPrice,
    required this.id,
  });

  factory Sku.fromJson(Map<String, dynamic> json) {
    return Sku(
      size: json['size']?.toString() ?? '',
      discount: json['discount'] ?? 0,
      inStock: json['in_stock'] ?? false,
      quantity: json['quantity'] ?? 0,
      actualPrice: (json['actualPrice'] is int)
          ? (json['actualPrice'] as int).toDouble()
          : (json['actualPrice'] is double)
              ? json['actualPrice']
              : 0.0,
      discountedPrice: (json['discountedPrice'] is int)
          ? (json['discountedPrice'] as int).toDouble()
          : (json['discountedPrice'] is double)
              ? json['discountedPrice']
              : 0.0,
      id: json['_id']?.toString() ?? '',
    );
  }
}
