abstract class CartEvent {}

class FetchCartEvent extends CartEvent {
  final String userId;

  FetchCartEvent(this.userId);
}

class AddToCartEvent extends CartEvent {
  final String userId;
  final String productId;
  final int quantity;

  AddToCartEvent(this.userId, this.productId, this.quantity);
}

class RemoveFromCartEvent extends CartEvent {
  final String userId;
  final String productId;

  RemoveFromCartEvent(this.userId, this.productId);
}

class UpdateCartEvent extends CartEvent {
  final String userId;
  final String productId;
  final int quantity;

  UpdateCartEvent(this.userId, this.productId, this.quantity);
}
