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
      id: json['_id'],
      customerId: json['customer'],
      items: List<OrderItem>.from(
        json['items'].map((item) => OrderItem.fromJson(item)),
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
      quantity: json['quantity'],
      id: json['_id'],
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
      id: json['_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      productDescription: json['product_description'],
      productCategory: json['product_category'],
      productType: json['product_type'],
      productWeight: json['product_weight'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      variations: List<Variation>.from(
        json['variations'].map((variation) => Variation.fromJson(variation)),
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
      color: json['color'],
      images: List<String>.from(json['images']),
      skus: List<Sku>.from(json['skus'].map((sku) => Sku.fromJson(sku))),
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
      size: json['size'],
      discount: json['discount'].toDouble(),
      inStock: json['in_stock'],
      quantity: json['quantity'],
      actualPrice: json['actualPrice'].toDouble(),
      discountedPrice: json['discountedPrice'].toDouble(),
      id: json['_id'],
    );
  }
}
