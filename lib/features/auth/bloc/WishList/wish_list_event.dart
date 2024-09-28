import 'package:equatable/equatable.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class FetchWishlist extends WishlistEvent {
  const FetchWishlist();

  @override
  List<Object> get props => [];
}

class CheckIfFavorited extends WishlistEvent {
  // final String userId;
  final String productId;

  CheckIfFavorited(this.productId);
}

class AddToWishlist extends WishlistEvent {
  //final String userId;
  final String productId;

  const AddToWishlist(this.productId);

  @override
  List<Object> get props => [productId];
}

class RemoveFromWishlist extends WishlistEvent {
  //final String userId;
  final String productId;

  const RemoveFromWishlist(this.productId);

  @override
  List<Object> get props => [productId];
}
