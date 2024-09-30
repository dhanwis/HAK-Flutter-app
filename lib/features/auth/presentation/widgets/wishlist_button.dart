import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final String productId;

  const FavoriteButton({required this.productId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(
      builder: (context, state) {
        print('State in button: $state');
        bool isWishlisted = false;

        if (state is WishlistLoaded) {
          print('Wishlist is loaded');

          // Assuming state.wishlist is a list of product objects, not just product IDs
          // Check if any product in the wishlist has the same product_id as the current productId
          isWishlisted =
              state.wishlist.any((product) => product['_id'] == productId);
        }

        return IconButton(
          icon: Icon(
            isWishlisted ? Icons.favorite : Icons.favorite_border,
            color: isWishlisted ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            print('Wishlist button pressed');
            if (isWishlisted) {
              print('Removing from wishlist');
              // Remove from wishlist
              context.read<WishlistBloc>().add(RemoveFromWishlist(productId));
            } else {
              print('Adding to wishlist');
              // Add to wishlist
              context.read<WishlistBloc>().add(AddToWishlist(productId));
            }
          },
        );
      },
    );
  }
}
