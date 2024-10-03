import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/api/addtocart_api.dart';
import 'package:dil_hack_e_commerce/constants/decodeJwt.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService cartService;
  String userId = '';
  List<String> cartItemIds =
      []; // This will hold the IDs of products in the cart

  CartBloc(this.cartService) : super(CartInitial()) {
    // Fetch the initial state of the cart when the BLoC is instantiated
    on<FetchCartEvent>((event, emit) async {
      print('Fetching cart items');
      await _initializeUserId();
      emit(CartLoading());
      try {
        final cartItems = await cartService.fetchCart(userId);
        print('Fetched cart items: $cartItems');
        //cartItemIds = cartItems.map((item) => item['productId']).toList(); // Assuming each item has a productId
        emit(CartLoaded(cartItems));
      } catch (e) {
        emit(CartError('Failed to fetch cart $e'));
      }
    });

    // Handling the AddToCartEvent
    on<AddToCartEvent>((event, emit) async {
      print('clic to add');
      await _initializeUserId();

      try {
        final response =
            await cartService.addToCart(userId, event.productId, 1);

        if (response['message'] == 'This product is already in the cart') {
          print('trye it does');
          emit(AlreadyInCart());
        } else {
          // Add the product ID to the local list of cart items
          print('try to adding again');
          cartItemIds.add(event.productId);
          emit(AddedToCart());
        }
      } catch (e) {
        emit(CartError('Failed to add to cart: ${e.toString()}'));
      }
    });

    // Handling the RemoveFromCart event
    on<RemoveFromCart>((event, emit) async {
      await _initializeUserId();
      print('Attempting to remove item from cart');
      try {
        await cartService.removeFromCart(userId, event.productId);
        cartItemIds.remove(
            event.productId); // Remove the product ID from the local list
        final carts = await cartService.fetchCart(userId);
        print('Updated cart after removal: $carts');
        emit(CartLoaded(carts));
      } catch (e) {
        emit(CartError(e.toString()));
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

  // New method to check if the product is in the cart
  bool isProductInCart(String productId) {
    return cartItemIds.contains(productId);
  }
}
