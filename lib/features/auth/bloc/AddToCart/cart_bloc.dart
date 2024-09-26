import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/api/addtocart_api.dart';
import 'package:dil_hack_e_commerce/constants/decodeJwt.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService cartService;
  String userId = '';

  CartBloc(this.cartService) : super(CartInitial()) {
    on<FetchCartEvent>((event, emit) async {
      await _initializeUserId();
      emit(CartLoading());
      try {
        print('cart items');
        final cartItems = await cartService.fetchCart(event.userId);
        print(cartItems);
        emit(CartLoaded(cartItems));
      } catch (e) {
        emit(CartError('Failed to fetch cart'));
      }
    });

    on<AddToCartEvent>((event, emit) async {
      await _initializeUserId();

      print('event bellow');
      print(event);

      try {
        bool isAlreadyInCart =
            await cartService.isProductInCart(userId, event.productId);

        if (isAlreadyInCart) {
          print('already in cart');
          emit(AlreadyInCart());
        } else {
          await cartService.addToCart(userId, event.productId, 1);
          print('added to acrt');
          emit(AddedToCart());
        }
      } catch (e) {
        print('error ');
        print(e);
        emit(CartError('Failed to add to cart'));
      }
    });

    on<CheckCartStatusEvent>((event, emit) async {
      await _initializeUserId();
      emit(CartLoading());
      try {
        bool isAlreadyInCart =
            await cartService.isProductInCart(userId, event.productId);
        if (isAlreadyInCart) {
          emit(AlreadyInCart());
        } else {
          emit(CartInitial());
        }
      } catch (e) {
        emit(CartError('Error checking cart status'));
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
