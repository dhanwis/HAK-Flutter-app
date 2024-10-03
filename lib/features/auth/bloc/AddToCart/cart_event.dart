import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {
  final String productId;

  AddToCartEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class RemoveFromCart extends CartEvent {
  final String productId;

  RemoveFromCart(this.productId);
}

class FetchCartEvent extends CartEvent {
  FetchCartEvent();

  @override
  List<Object> get props => [];
}
