import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  final List<dynamic> cartItems;

  CartLoaded(this.cartItems);
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class AddedToCart extends CartState {}

class AlreadyInCart extends CartState {}

class CartError extends CartState {
  final String message;

  CartError(this.message);

  @override
  List<Object> get props => [message];
}
