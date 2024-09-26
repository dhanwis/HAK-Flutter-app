import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class FetchCartEvent extends CartEvent {
  final String userId;

  FetchCartEvent(this.userId);
}

class AddToCartEvent extends CartEvent {
  final String productId;

  AddToCartEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class CheckCartStatusEvent extends CartEvent {
  final String productId;

  CheckCartStatusEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
