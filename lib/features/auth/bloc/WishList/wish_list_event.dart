// wishlist_event.dart
abstract class WishlistEvent {}

class AddToWishlist extends WishlistEvent {
  final String productId;

  AddToWishlist(this.productId);
}

class RemoveFromWishlist extends WishlistEvent {
  final String productId;

  RemoveFromWishlist(this.productId);
}

class FetchWishlistItems extends WishlistEvent {
  FetchWishlistItems();

  @override
  List<Object> get props => [];
}
