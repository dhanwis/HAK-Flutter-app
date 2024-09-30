import 'package:equatable/equatable.dart';

// wishlist_state.dart
abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<dynamic> wishlist;

  WishlistLoaded(this.wishlist);

  @override
  List<Object> get props => [wishlist];
}

class WishlistError extends WishlistState {
  final String message;

  WishlistError(this.message);
}
