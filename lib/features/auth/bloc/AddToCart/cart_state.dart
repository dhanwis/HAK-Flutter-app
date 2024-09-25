abstract class CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<dynamic> cartItems;

  CartLoadedState(this.cartItems);
}

class CartErrorState extends CartState {
  final String message;

  CartErrorState(this.message);
}

class CartUpdatedState extends CartState {
  final List<dynamic> cartItems;

  CartUpdatedState(this.cartItems);
}
