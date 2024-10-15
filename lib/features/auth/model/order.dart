class Order {
  final String id;
  final String customerId;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.customerId,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'] ?? '', // Use an empty string if null
      customerId: json['customer'] ?? '', // Use an empty string if null
      items: List<OrderItem>.from(
        (json['products'] ?? []).map((item) => OrderItem.fromJson(item)),
      ),
    );
  }
}

class OrderItem {
  final Product product;
  final int quantity;
  final String id;

  OrderItem({
    required this.product,
    required this.quantity,
    required this.id,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'] ?? 0, // Use 0 if null
      id: json['_id'] ?? '', // Use an empty string if null
    );
  }
}

class Product {
  final String id;
  final String productId;
  final String productName;
  final String productDescription;
  final String productCategory;
  final String productType;
  final double productWeight;
  final DateTime createdAt;
  final List<Variation> variations;

  Product({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productCategory,
    required this.productType,
    required this.productWeight,
    required this.createdAt,
    required this.variations,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '', // Use empty string if null
      productId: json['product_id'] ?? '', // Use empty string if null
      productName:
          json['product_name'] ?? 'Unknown Product', // Default product name
      productDescription: json['product_description'] ??
          'No description available', // Default description
      productCategory:
          json['product_category'] ?? '', // Use empty string if null
      productType: json['product_type'] ?? '', // Use empty string if null
      productWeight:
          (json['product_weight'] ?? 0).toDouble(), // Use 0.0 if null
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(), // Use current time if null
      variations: List<Variation>.from(
        (json['variations'] ?? [])
            .map((variation) => Variation.fromJson(variation)),
      ),
    );
  }
}

class Variation {
  final String color;
  final List<String> images;
  final List<Sku> skus;

  Variation({
    required this.color,
    required this.images,
    required this.skus,
  });

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      color: json['color'] ?? 'Unknown color', // Default color
      images: List<String>.from(json['images'] ?? []), // Empty list if null
      skus: List<Sku>.from(
        (json['skus'] ?? []).map((sku) => Sku.fromJson(sku)),
      ), // Empty list if null
    );
  }
}

class Sku {
  final String size;
  final double discount;
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
      size: json['size'] ?? 'Unknown size', // Default size
      discount: (json['discount'] ?? 0).toDouble(), // Use 0.0 if null
      inStock: json['in_stock'] ?? false, // Use false if null
      quantity: json['quantity'] ?? 0, // Use 0 if null
      actualPrice: (json['actualPrice'] ?? 0).toDouble(), // Use 0.0 if null
      discountedPrice:
          (json['discountedPrice'] ?? 0).toDouble(), // Use 0.0 if null
      id: json['_id'] ?? '', // Use empty string if null
    );
  }
}
