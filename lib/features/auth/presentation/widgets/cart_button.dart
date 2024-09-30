import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToCartButtonState extends StatelessWidget {
  final String productId;

  const AddToCartButtonState({required this.productId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              if (state is! AlreadyInCart && state is! CartLoading) {
                BlocProvider.of<CartBloc>(context)
                    .add(AddToCartEvent(productId));
              } else if (state is AlreadyInCart) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('This product is already in your cart')),
                );
              }
            },
            icon: Icon(
              state is AlreadyInCart
                  ? Icons.shopping_cart_outlined
                  : Icons.shopping_cart,
              color: Colors.black,
            ),
            label: Text(
              state is AlreadyInCart ? 'In Cart' : 'Add to Cart',
              style: GoogleFonts.aBeeZee(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(
                color: Color(0xFFFAAAB1),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        );
      },
    );
  }
}
