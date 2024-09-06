import 'package:dil_hack_e_commerce/api/wishList_api.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatefulWidget {
  final String productId;
  final String userId;
  final bool isInitiallyFavorite;

  FavoriteButton({
    required this.productId,
    required this.userId,
    this.isInitiallyFavorite = false,
  });

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isInitiallyFavorite; // Set initial favorite state
  }

  Future<void> _toggleFavorite() async {
    print(widget.userId);
    print(widget.productId);
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      // Dispatch AddToWishlist event
      // BlocProvider.of<WishlistBloc>(context)
      //     .add(AddToWishlist(widget.userId, widget.productId));
      print('true to continue');
      print('userId ${widget.userId}');
      print('productId ${widget.productId}');
      await WishlistService()
          .addToWishlist('66d8248f4b26f2406ef5c49b', widget.productId);
    } else {
      // Dispatch RemoveFromWishlist event
      BlocProvider.of<WishlistBloc>(context)
          .add(RemoveFromWishlist(widget.userId, widget.productId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.black,
        size: 18,
      ),
      onPressed: _toggleFavorite,
    );
  }
}
