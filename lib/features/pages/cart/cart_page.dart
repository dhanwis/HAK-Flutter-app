import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_state.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    print('n cart page');
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Cart',
          style: GoogleFonts.aBeeZee(
            color: Colors.black,
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          print('state in cart $state');
          if (state is CartLoading) {
            // Show the loading indicator while the wishlist is being fetched
            return Center(
                child: SpinKitFadingCircle(
              color: Color(0xFFFAAAB1),
              size: 50.0, // Adjust the size as needed
            ));
          } else if (state is CartLoaded) {
            //nee print full kaliyane ippo, ok,
            // Show the wishlist items when they are loaded
            if (state.cartItems.isEmpty) {
              return Center(child: Text("No items in your wishlist"));
            }

            return GridView.builder(
              itemCount: state.cartItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.55,
              ),
              itemBuilder: (context, index) {
                final product = state.cartItems[index];
                // final screenHeight = MediaQuery.of(context).size.height;
                return _cartUI(context, product, screenHeight, screenWidth);
              },
            );
          } else if (state is CartError) {
            // Show an error message if there's an error fetching the wishlist
            //return Center(child: Text(state.message));
            return _emptyUI();
          }
          print('Something went wrong on cart!');
          return Center(child: Text("Something went wrong on cart!"));
        },
      ),
    );
  }
} //avathe ? booth poya
//run aavuuu waittt

Widget _cartUI(BuildContext context, Map<String, dynamic> cartItem,
    double screenHeight, double screenWidth) {
  final Map<String, dynamic> product = cartItem['product'] ?? {};

  // Extracting variations and images
  final firstVariation = product['variations']?.isNotEmpty == true
      ? product['variations'][0]
      : null;
  final firstImage =
      firstVariation != null && firstVariation['images']?.isNotEmpty == true
          ? firstVariation['images'][0]
          : null;
  final sku =
      firstVariation != null && firstVariation['skus']?.isNotEmpty == true
          ? firstVariation['skus'][0]
          : null;

  // Extracting product details
  final productName = product['product_name'] ?? 'Unknown Product';
  final productId = product['product_id'] ??
      'Unknown Product'; // Accessing product_id correctly
  final actualPrice = sku?['actualPrice']?.toString() ?? 'N/A';
  final discountedPrice = sku?['discountedPrice']?.toString() ?? 'N/A';
  final rating = product['rating'] ?? 10;
  final ratingCount = product['ratingCount']?.toString() ?? '0';

  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(left: 8, right: 8, top: 8),
            children: [
              Card(
                color: Color.fromARGB(248, 239, 238, 239),
                elevation: 0,
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.01,
                    vertical: screenHeight * 0.01),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.01,
                      vertical: screenHeight * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            '${AppConstants.BASE_URL}/ProductImg/$productId/$firstImage',
                            width: screenWidth * 0.25,
                            height: screenWidth * 0.25,
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ), // ipo okylle

                                SizedBox(height: screenHeight * 0.01),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.blue,
                                        size: screenWidth * 0.04),
                                    Icon(Icons.star,
                                        color: Colors.blue,
                                        size: screenWidth * 0.04),
                                    Icon(Icons.star,
                                        color: Colors.blue,
                                        size: screenWidth * 0.04),
                                    Icon(Icons.star,
                                        color: Colors.blue,
                                        size: screenWidth * 0.04),
                                    Icon(Icons.star_half,
                                        color: Colors.blue,
                                        size: screenWidth * 0.04),
                                    SizedBox(width: screenWidth * 0.01),
                                    Text('(4.5)',
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '₹$actualPrice',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 12.0,
                                        color: Colors.black54,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    if (discountedPrice.isNotEmpty)
                                      Text(
                                        '₹$discountedPrice with 1 Special Offer',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.green,
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Text('Delivery by Sept 18',
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: screenWidth * 0.03)),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  'Free Delivery',
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.green,
                                      fontSize: screenWidth * 0.03),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Qty: ',
                                    style: TextStyle(fontSize: 14)),
                              ),
                              DropdownButton<int>(
                                value: 1,
                                items: [
                                  DropdownMenuItem(value: 1, child: Text('1')),
                                  DropdownMenuItem(value: 2, child: Text('2')),
                                  DropdownMenuItem(value: 3, child: Text('3')),
                                ],
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Remove Button
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.delete, color: Colors.black),
                        label: Text('Remove',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black)),
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(248, 239, 238, 239),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),

                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.bookmark, color: Colors.black),
                        label: Text('Save',
                            style: TextStyle(
                                fontSize: 12,
                                color: const Color.fromARGB(255, 92, 92, 92))),
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(248, 239, 238, 239),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),

                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderScreen()),
                          );
                        },
                        icon: Icon(Icons.flash_on, color: Colors.black),
                        label: Text('Buy now',
                            style:
                                TextStyle(fontSize: 11, color: Colors.black)),
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(248, 239, 238, 239),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 4),
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Amount',
                      style: GoogleFonts.aBeeZee(fontSize: 14)),
                  Text(
                    actualPrice,
                    style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFAAAB1),
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.01),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderScreen()),
                  );
                },
                child: Text(
                  'Proceed to Buy',
                  style: GoogleFonts.aBeeZee(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
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
