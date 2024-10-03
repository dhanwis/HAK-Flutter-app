class Order {
  final String id;
  final String productId;
  final int quantity;
  final String status;
  final DateTime orderDate;

  Order({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.status,
    required this.orderDate,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      productId: json['productId'],
      quantity: json['quantity'],
      status: json['status'],
      orderDate: DateTime.parse(json['orderDate']),
    );
  }
}
