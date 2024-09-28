import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatefulWidget {
  final String productId;

  FavoriteButton({
    required this.productId,
  });

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false; // Initial value for favorite status

  @override
  void initState() {
    super.initState();
    print('starting');

    // Dispatch event to check initial favorite status when the button is created
    BlocProvider.of<WishlistBloc>(context)
        .add(CheckIfFavorited(widget.productId));
  }

  void _toggleFavorite() {
    if (isFavorite) {
      // If already favorited, dispatch event to remove from wishlist
      BlocProvider.of<WishlistBloc>(context)
          .add(RemoveFromWishlist(widget.productId));
    } else {
      // If not favorited, dispatch event to add to wishlist
      BlocProvider.of<WishlistBloc>(context)
          .add(AddToWishlist(widget.productId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc, WishlistState>(
      listener: (context, state) {
        // Listen for changes in favorite status and update `isFavorite`
        if (state is WishlistFavoritedStatus) {
          print('state is WishlistFavoritedStatus');
          setState(() {
            if (widget.productId == state.productId) {
              print('yes matched');
              isFavorite = state.isFavorited;
            }
          });
        }

        // Listen for changes when a product is added or removed from wishlist
        if (state is WishlistUpdated) {
          print('updated');
          setState(() {
            if (widget.productId == state.productId) {
              isFavorite = state.isFavorited;
            }
          });
        }
      },
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.black,
            size: 18,
          ),
          onPressed: _toggleFavorite,
        );
      },
    );
  }
}
