import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/api/wishList_api.dart';
import 'package:dil_hack_e_commerce/constants/decodeJwt.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistService wishlistService;
  String userId = '';

  WishlistBloc(this.wishlistService) : super(WishlistInitial()) {
    // Handler for AddToWishlist event
    on<AddToWishlist>((event, emit) async {
      await _initializeUserId();

      try {
        await wishlistService.addToWishlist(userId, event.productId);
        final wishlist = await wishlistService.fetchWishlist(userId);

        emit(WishlistLoaded(wishlist));
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });

    // Handler for RemoveFromWishlist event
    on<RemoveFromWishlist>((event, emit) async {
      await _initializeUserId();

      try {
        await wishlistService.removeFromWishlist(userId, event.productId);
        final wishlist = await wishlistService.fetchWishlist(userId);

        emit(WishlistLoaded(wishlist));
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });

    // Handler for FetchWishlistItems event
    on<FetchWishlistItems>((event, emit) async {
      emit(WishlistLoading());

      await _initializeUserId();

      try {
        final wishlist = await wishlistService.fetchWishlist(userId);

        emit(WishlistLoaded(wishlist));
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });
  }

  Future<void> _initializeUserId() async {
    if (userId.isEmpty) {
      // Ensure that userId is initialized only once
      try {
        final decodedToken =
            await decodeJwt(); // Use your existing decodeJwt method
        userId = decodedToken['userId']; // Assuming userId is part of the token
      } catch (e) {}
    }
  }
}
