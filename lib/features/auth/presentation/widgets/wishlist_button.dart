import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatefulWidget {
  final String productId;

  FavoriteButton({required this.productId});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    // Check if the product is already in the wishlist when initializing the widget
    BlocProvider.of<WishlistBloc>(context)
        .add(CheckIfFavorited(widget.productId));
  }

  void _toggleFavorite() {
    if (isFavorite) {
      // Remove from wishlist
      BlocProvider.of<WishlistBloc>(context)
          .add(RemoveFromWishlist(widget.productId));
    } else {
      // Add to wishlist
      BlocProvider.of<WishlistBloc>(context)
          .add(AddToWishlist(widget.productId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WishlistBloc, WishlistState>(
      listener: (context, state) {
        // Listen for specific state changes to update the button
        if (state is WishlistFavoritedStatus &&
            state.productId == widget.productId) {
          setState(() {
            isFavorite = state.isFavorited;
          });
        }
      },
      child: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : Colors.black,
        ),
        onPressed: _toggleFavorite,
      ),
    );
  }
}
