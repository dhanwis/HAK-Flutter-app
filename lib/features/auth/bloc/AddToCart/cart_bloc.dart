import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/api/addtocart_api.dart';
import 'package:dil_hack_e_commerce/constants/decodeJwt.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService cartService;
  String userId = '';

  CartBloc(this.cartService) : super(CartInitial()) {
    on<AddToCartEvent>((event, emit) async {
      await _initializeUserId();

      try {
        // Call the service to add the product to the cart and get a response
        final response =
            await cartService.addToCart(userId, event.productId, 1);

        // Check if the response contains the "This product is already in the cart" message
        if (response['message'] == 'This product is already in the cart') {
          // Emit a state indicating that the product is already in the cart
          emit(AlreadyInCart());
        } else {
          // Emit a state indicating the product was successfully added to the cart
          emit(AddedToCart());
        }
      } catch (e) {
        emit(CartError('Failed to add to cart: ${e.toString()}'));
      }
    });

    on<RemoveFromCart>((event, emit) async {
      await _initializeUserId();
      print('working delete');
      try {
        await cartService.removeFromCart(userId, event.productId);
        final carts = await cartService.fetchCart(userId);
        print('remove the carts $carts');
        emit(CartLoaded(carts));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<FetchCartEvent>((event, emit) async {
      print('call now');
      await _initializeUserId();
      emit(CartLoading());
      try {
        print('fetch all cats');
        final cartItems = await cartService.fetchCart(userId);
        print('cartItems cating $cartItems');
        emit(CartLoaded(cartItems));
      } catch (e) {
        emit(CartError('Failed to fetch cart $e'));
      }
    });
  }

  Future<void> _initializeUserId() async {
    if (userId.isEmpty) {
      try {
        final decodedToken =
            await decodeJwt(); // Use your existing decodeJwt method
        userId = decodedToken['userId']; // Assuming userId is part of the token
      } catch (e) {
        print("Error decoding token: $e");
      }
    }
  }
}
