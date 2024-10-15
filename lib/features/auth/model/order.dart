// class Order {
//   final String id;
//   final String customerId;
//   final List<OrderItem> items;

//   Order({
//     required this.id,
//     required this.customerId,
//     required this.items,
//   });

//   factory Order.fromJson(Map<String, dynamic> json) {
//     return Order(
//       id: json['_id'] ?? '', // Use an empty string if null
//       customerId: json['customer'] ?? '', // Use an empty string if null
//       items: List<OrderItem>.from(
//         (json['products'] ?? []).map((item) => OrderItem.fromJson(item)),
//       ),
//     );
//   }
// }

// class OrderItem {
//   final Product product;
//   final int quantity;
//   final String id;

//   OrderItem({
//     required this.product,
//     required this.quantity,
//     required this.id,
//   });

//   factory OrderItem.fromJson(Map<String, dynamic> json) {
//     return OrderItem(
//       product: Product.fromJson(json['product']),
//       quantity: json['quantity'] ?? 0, // Use 0 if null
//       id: json['_id'] ?? '', // Use an empty string if null
//     );
//   }
// }

// class Product {
//   final String id;
//   final String productId;
//   final String productName;
//   final String productDescription;
//   final String productCategory;
//   final Variation variant;
//   final Sku sku;
//   final int quantity;
//   final double price;

//   Product({
//     required this.id,
//     required this.productId,
//     required this.productName,
//     required this.productDescription,
//     required this.productCategory,
//     required this.variant,
//     required this.sku,
//     required this.quantity,
//     required this.price,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     print('json $json');
//     return Product(
//       id: json['id'] ?? '',
//       productId: json['product_id'] ?? '',
//       productName: json['product_name'] ?? 'Unknown Product',
//       productDescription:
//           json['product_description'] ?? 'No description available',
//       productCategory: json['product_categoryName']['label'] ??
//           '', // Adjust based on the nested structure
//       variant: Variation.fromJson(json['variant']),
//       sku: Sku.fromJson(json['sku']),
//       quantity: json['quantity'] ?? 0,
//       price: (json['price'] ?? 0).toDouble(),
//     );
//   }
// }

// // Make sure DeliveryAddress and OrderItem have their own fromJson methods.
// class DeliveryAddress {
//   final String username;
//   final String email;
//   final String phone;
//   final String street;
//   final String city;
//   final String state;
//   final String country;
//   final String pinCode;

//   DeliveryAddress({
//     required this.username,
//     required this.email,
//     required this.phone,
//     required this.street,
//     required this.city,
//     required this.state,
//     required this.country,
//     required this.pinCode,
//   });

//   factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
//     return DeliveryAddress(
//       username: json['username'] ?? '',
//       email: json['email'] ?? '',
//       phone: json['phone'] ?? '',
//       street: json['street'] ?? '',
//       city: json['city'] ?? '',
//       state: json['state'] ?? '',
//       country: json['country'] ?? '',
//       pinCode: json['pinCode'] ?? '',
//     );
//   }
// }

// class Variation {
//   final String variantId; // Added to match your variant structure
//   final String color;
//   final List<String> images;

//   Variation({
//     required this.variantId,
//     required this.color,
//     required this.images,
//   });

//   factory Variation.fromJson(Map<String, dynamic> json) {
//     return Variation(
//       variantId: json['variantId'] ?? '', // Added variantId
//       color: json['color'] ?? 'Unknown color',
//       images: List<String>.from(json['images'] ?? []),
//     );
//   }
// }

// class Sku {
//   final String size;
//   final double actualPrice;
//   final double discountedPrice;
//   final String skuCode; // Added to match your sku structure
//   final String id;

//   Sku({
//     required this.size,
//     required this.actualPrice,
//     required this.discountedPrice,
//     required this.skuCode,
//     required this.id,
//   });

//   factory Sku.fromJson(Map<String, dynamic> json) {
//     return Sku(
//       size: json['size'] ?? 'Unknown size',
//       actualPrice: (json['actualPrice'] ?? 0).toDouble(),
//       discountedPrice: (json['discountedPrice'] ?? 0).toDouble(),
//       skuCode: json['skuCode'] ?? '',
//       id: json['_id'] ?? '',
//     );
//   }
// }

class Order {
  final String id;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DeliveryAddress deliveryAddress;
  final List<Product> products;
  final double totalAmount;
  final double shippingCost;
  final PaymentInfo paymentInfo;
  final ShippingMethod shippingMethod;

  Order({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deliveryAddress,
    required this.products,
    required this.totalAmount,
    required this.shippingCost,
    required this.paymentInfo,
    required this.shippingMethod,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deliveryAddress: DeliveryAddress.fromJson(json['deliveryAddress']),
      products:
          (json['products'] as List).map((i) => Product.fromJson(i)).toList(),
      totalAmount: json['totalAmount'].toDouble(),
      shippingCost: json['shippingCost'].toDouble(),
      paymentInfo: PaymentInfo.fromJson(json['paymentInfo']),
      shippingMethod: ShippingMethod.fromJson(json['shippingMethod']),
    );
  }
}

class DeliveryAddress {
  final String street;
  final String city;
  final String state;
  final String country;
  final String pinCode;

  DeliveryAddress({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.pinCode,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      pinCode: json['pinCode'],
    );
  }
}

class Product {
  final String productId;
  final String productName;
  final String productBrand;
  final String productDescription;
  final Variant variant;
  final Sku sku;
  final int quantity;
  final double price;

  Product({
    required this.productId,
    required this.productName,
    required this.productBrand,
    required this.productDescription,
    required this.variant,
    required this.sku,
    required this.quantity,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      productName: json['product_name'],
      productBrand: json['product_brand'],
      productDescription: json['product_description'],
      variant: Variant.fromJson(json['variant']),
      sku: Sku.fromJson(json['sku']),
      quantity: json['quantity'],
      price: json['price'].toDouble(),
    );
  }
}

class Variant {
  final String color;
  final List<String> images;

  Variant({
    required this.color,
    required this.images,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      color: json['color'],
      images: List<String>.from(json['images']),
    );
  }
}

class Sku {
  final String size;
  final String skuCode;

  Sku({
    required this.size,
    required this.skuCode,
  });

  factory Sku.fromJson(Map<String, dynamic> json) {
    return Sku(
      size: json['size'],
      skuCode: json['skuCode'],
    );
  }
}

class PaymentInfo {
  final String method;
  final String status;

  PaymentInfo({
    required this.method,
    required this.status,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      method: json['method'],
      status: json['status'],
    );
  }
}

class ShippingMethod {
  final String shipmentStatus;
  final String? estimatedDelivery;

  ShippingMethod({
    required this.shipmentStatus,
    this.estimatedDelivery,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) {
    return ShippingMethod(
      shipmentStatus: json['shipmentStatus'],
      estimatedDelivery: json['estimatedDelivery'],
    );
  }
}
