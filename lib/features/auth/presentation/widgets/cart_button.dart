import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToCartButton extends StatefulWidget {
  final String productId;

  const AddToCartButton({required this.productId});

  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  void initState() {
    super.initState();
    // Check if the product is already in the cart
    BlocProvider.of<CartBloc>(context)
        .add(CheckCartStatusEvent(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        print('state bellow');
        print(state);
        if (state is AddedToCart) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product added to cart')),
          );
        } else if (state is AlreadyInCart) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product is already in the cart')),
          );
        } else if (state is CartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              if (state is! AlreadyInCart && state is! CartLoading) {
                BlocProvider.of<CartBloc>(context)
                    .add(AddToCartEvent(widget.productId));
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
