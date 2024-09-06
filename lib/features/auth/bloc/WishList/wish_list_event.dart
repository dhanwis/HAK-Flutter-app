import 'package:equatable/equatable.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class FetchWishlist extends WishlistEvent {
  final String userId;

  const FetchWishlist(this.userId);

  @override
  List<Object> get props => [userId];
}

class AddToWishlist extends WishlistEvent {
  final String userId;
  final String productId;

  const AddToWishlist(this.userId, this.productId);

  @override
  List<Object> get props => [userId, productId];
}

class RemoveFromWishlist extends WishlistEvent {
  final String userId;
  final String productId;

  const RemoveFromWishlist(this.userId, this.productId);

  @override
  List<Object> get props => [userId, productId];
}
