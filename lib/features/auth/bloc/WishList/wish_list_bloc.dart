import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/api/wishList_api.dart';
import 'package:dil_hack_e_commerce/constants/decodeJwt.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistService wishlistService;
  String userId = '';

  WishlistBloc(this.wishlistService) : super(WishlistInitial()) {
    on<FetchWishlist>((event, emit) async {
      print('fetchng');
      emit(WishlistLoading());

      // Initialize userId before proceeding
      await _initializeUserId();

      try {
        final wishlist = await wishlistService.fetchWishlist(userId);

        emit(WishlistLoaded(wishlist));
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });

    on<CheckIfFavorited>((event, emit) async {
      await _initializeUserId();
      print('WishlistFavoritedStatus');
      try {
        final isFavorited =
            await wishlistService.checkisFavour(userId, event.productId);

        emit(WishlistFavoritedStatus(
            isFavorited: isFavorited,
            productId: event.productId)); // isFavorited should now be a bool
      } catch (error) {
        emit(WishlistError(error.toString()));
      }
    });

    on<AddToWishlist>((event, emit) async {
      await _initializeUserId();
      try {
        await wishlistService.addToWishlist(userId, event.productId);
        final wishlist = await wishlistService.fetchWishlist(userId);

        emit(WishlistLoaded(wishlist)); // Update the entire wishlist
        emit(WishlistFavoritedStatus(
            isFavorited: true, productId: event.productId));
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });

    on<RemoveFromWishlist>((event, emit) async {
      await _initializeUserId();
      try {
        await wishlistService.removeFromWishlist(userId, event.productId);
        final wishlist = await wishlistService.fetchWishlist(userId);

        emit(WishlistLoaded(wishlist)); // Update the entire wishlist
        emit(WishlistFavoritedStatus(
            isFavorited: false, productId: event.productId));
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });
  }

  // Method to initialize userId from the token
  Future<void> _initializeUserId() async {
    if (userId.isEmpty) {
      // Ensure that userId is initialized only once
      try {
        final decodedToken =
            await decodeJwt(); // Use your existing decodeJwt method
        userId = decodedToken['userId']; // Assuming userId is part of the token
        print('User ID initialized: $userId');
      } catch (e) {
        print("Error decoding token: $e");
      }
    }
  }
}
