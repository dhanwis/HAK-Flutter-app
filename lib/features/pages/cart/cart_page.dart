import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CartView extends StatefulWidget {
  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch cart when the widget is initialized or dependencies change
    context.read<CartBloc>().add(FetchCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CartPage();
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Cart',
          style: GoogleFonts.aBeeZee(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoaded) {
            if (state.cartItems.isEmpty) {
              return Center(child: Text("No items in your cart"));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = state.cartItems[index];
                      return _cartUI(context, product);
                    },
                  ),
                ),
                _bottomSection(context, state.cartItems),
              ],
            );
          } else if (state is CartError) {
            return Center(child: Text("Something went wrong"));
          }
          return Center(child: Text("Something went wrong"));
        },
      ),
    );
  }

  Widget _bottomSection(BuildContext context, List<dynamic> cartItems) {
    // Calculate total price based on items in the cart
    final totalPrice = cartItems.fold<double>(
      0,
      (sum, item) {
        final sku = item['product']['variations'][0]['skus'][0];
        final discountedPrice = sku?['discountedPrice'] ?? 0;
        return sum + discountedPrice;
      },
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Amount: ₹${totalPrice.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle Proceed to Buy action
            },
            child: Text("Proceed to Buy"),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.pink, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartUI(BuildContext context, Map<String, dynamic> cartItem) {
    final product = cartItem['product'];
    final firstVariation =
        product['variations'].isNotEmpty ? product['variations'][0] : null;
    final firstImage =
        firstVariation != null && firstVariation['images'].isNotEmpty
            ? firstVariation['images'][0]
            : null;
    final sku = firstVariation != null && firstVariation['skus'].isNotEmpty
        ? firstVariation['skus'][0]
        : null;

    final productName = product['product_name'] ?? 'Unknown Product';
    final actualPrice = sku?['actualPrice']?.toString() ?? 'N/A';
    final discountedPrice = sku?['discountedPrice']?.toString() ?? 'N/A';
    final rating = product['rating'] ?? 0;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              child: firstImage != null
                  ? Image.network(
                      '${AppConstants.BASE_URL}/ProductImg/$productName/$firstImage',
                      fit: BoxFit.cover,
                    )
                  : Placeholder(),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: GoogleFonts.aBeeZee(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.blue,
                        size: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '₹$actualPrice',
                    style: TextStyle(
                      color: Colors.black54,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Text(
                    '₹$discountedPrice',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Free Delivery by Sept 18',
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      _cartButton('Remove', Colors.red, () {}),
                      SizedBox(width: 8),
                      _cartButton('Save', Colors.grey, () {}),
                      SizedBox(width: 8),
                      _cartButton('Buy Now', Colors.pink, () {}),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(80, 35),
      ),
    );
  }
}

Widget _emptyUI() {
  return Scaffold(
    body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 180),
          child: Lottie.asset(
            'assets/images/Animation - 1717999632927 (1).json',
            height: 200,
            width: 200,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text("Your Cart Is Empty !",
              style: TextStyle(
                  fontWeight: FontWeight.w200,
                  color: Colors.grey.shade500,
                  fontSize: 15)),
        ),
        SizedBox(
          height: 20,
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 100, right: 100),
        //   child: ElevatedButton(
        //     child: const Text(
        //       'Shop Now',
        //       style: TextStyle(color: Colors.black),
        //     ),
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => AccountPage(),
        //           ));
        //     },
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: const Color(0xFFFAAAB1),
        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}
//extra branch add akkua manjima 0.1//pull nu mumb extra branch create aakua // pazhebranch kerit pull.....