import 'package:equatable/equatable.dart';

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
  // final String userId;

  // FetchWishlistItems(this.userId);

  FetchWishlistItems();

  @override
  List<Object> get props => [];
}
