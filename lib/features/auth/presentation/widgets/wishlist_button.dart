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
  bool isFavorite = false; // Initial value for isFavorite

  @override
  void initState() {
    super.initState();
    // Dispatch the CheckIfFavorited event to get the initial state
    BlocProvider.of<WishlistBloc>(context)
        .add(CheckIfFavorited(widget.productId));
  }

  void _toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      // Dispatch AddToWishlist event
      BlocProvider.of<WishlistBloc>(context)
          .add(AddToWishlist(widget.productId));
    } else {
      // Dispatch RemoveFromWishlist event
      BlocProvider.of<WishlistBloc>(context)
          .add(RemoveFromWishlist(widget.productId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc, WishlistState>(
      listener: (context, state) {
        if (state is WishlistFavoritedStatus &&
            state.productId == widget.productId) {
          // Ensure we're updating only for the current product
          setState(() {
            isFavorite =
                state.isFavorited; // Update isFavorite based on the state
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
