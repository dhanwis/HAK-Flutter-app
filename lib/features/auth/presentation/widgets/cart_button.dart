import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_state.dart';
import 'package:dil_hack_e_commerce/features/pages/WishList/wish_list.dart';
import 'package:dil_hack_e_commerce/features/pages/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToCartButtonState extends StatelessWidget {
  final String productId;

  const AddToCartButtonState({required this.productId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is NavigateToCart) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        } else if (state is AddedToCart) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Product added to cart successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is CartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        // Use a local variable to check if the product is in the cart
        final isInCart = context.select<CartBloc, bool>(
          (cartBloc) => cartBloc.isProductInCart(productId),
        );

        return Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              if (state is! CartLoading) {
                if (isInCart) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                } else {
                  BlocProvider.of<CartBloc>(context)
                      .add(AddToCartEvent(productId));
                }
              }
            },
            icon: Icon(
              isInCart ? Icons.shopping_cart_outlined : Icons.shopping_cart,
              color: Colors.black,
            ),
            label: Text(
              isInCart ? 'Go to Cart' : 'Add to Cart',
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
