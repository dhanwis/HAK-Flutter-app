class Order {
  final String id;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DeliveryAddress deliveryAddress;
  final List<ProductData> products;
  final double totalAmount;
  final double shippingCost;
  final PaymentInfo paymentInfo;
  //final ShippingMethod shippingMethod;

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
    //required this.shippingMethod,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deliveryAddress: DeliveryAddress.fromJson(json['deliveryAddress']),
      products: (json['products'] as List)
          .map((i) => ProductData.fromJson(i))
          .toList(),
      totalAmount: json['totalAmount'].toDouble(),
      shippingCost: json['shippingCost'].toDouble(),
      paymentInfo: PaymentInfo.fromJson(json['paymentInfo']),
      //shippingMethod: ShippingMethod.fromJson(json['shippingMethod']),
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

class ProductData {
  final String id;
  final String productId;
  final String productName;
  final String productBrand;
  final String productDescription;
  final Variant variant;
  final Sku sku;
  final int quantity;
  final double price;

  ProductData({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productBrand,
    required this.productDescription,
    required this.variant,
    required this.sku,
    required this.quantity,
    required this.price,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
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
