import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/api/addtocart_api.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService cartService;

  CartBloc(this.cartService) : super(CartLoadingState());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is FetchCartEvent) {
      yield CartLoadingState();
      try {
        final cartItems = await cartService.fetchCart(event.userId);
        yield CartLoadedState(cartItems);
      } catch (e) {
        yield CartErrorState('Failed to fetch cart');
      }
    } else if (event is AddToCartEvent) {
      try {
        await cartService.addToCart(
            event.userId, event.productId, event.quantity);
        final cartItems = await cartService.fetchCart(event.userId);
        yield CartUpdatedState(cartItems);
      } catch (e) {
        yield CartErrorState('Failed to add product to cart');
      }
    } else if (event is RemoveFromCartEvent) {
      try {
        await cartService.removeFromCart(event.userId, event.productId);
        final cartItems = await cartService.fetchCart(event.userId);
        yield CartUpdatedState(cartItems);
      } catch (e) {
        yield CartErrorState('Failed to remove product from cart');
      }
    } else if (event is UpdateCartEvent) {
      try {
        await cartService.updateCart(
            event.userId, event.productId, event.quantity);
        final cartItems = await cartService.fetchCart(event.userId);
        yield CartUpdatedState(cartItems);
      } catch (e) {
        yield CartErrorState('Failed to update cart');
      }
    }
  }
}
