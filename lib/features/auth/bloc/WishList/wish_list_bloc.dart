import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/api/wishList_api.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistService wishlistService;

  WishlistBloc(this.wishlistService) : super(WishlistInitial()) {
    on<FetchWishlist>((event, emit) async {
      emit(WishlistLoading());
      try {
        final wishlist = await wishlistService.fetchWishlist(event.userId);
        print('here the wishlist $wishlist');
        emit(WishlistLoaded(wishlist));
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });

    on<AddToWishlist>((event, emit) async {
      try {
        await wishlistService.addToWishlist(event.userId, event.productId);
        final wishlist = await wishlistService.fetchWishlist(event.userId);

        print('add  the wishlist $wishlist');
        emit(WishlistLoaded(wishlist));
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });

    on<RemoveFromWishlist>((event, emit) async {
      try {
        await wishlistService.removeFromWishlist(event.userId, event.productId);
        final wishlist = await wishlistService.fetchWishlist(event.userId);
        print('remove the wishlist $wishlist');
        emit(WishlistLoaded(wishlist));
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });
  }
}
