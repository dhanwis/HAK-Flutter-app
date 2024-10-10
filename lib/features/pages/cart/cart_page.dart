import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

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
    return const CartPage();
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
          print('state is in cart $state');
          if (state is CartLoading) {
            return const Center(
                child: SpinKitFadingCircle(
              color: Color(0xFFFAAAB1),
              size: 50.0, // Adjust the size as needed
            ));
          } else if (state is CartLoaded) {
            // if (state.cartItems.isEmpty) {
            //   return Center(child: Text("No items in your wishlist"));
            // }

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
              ],
            );
          } else if (state is CartError) {
            print('empty is error now');
            print(state.message);
            // return _emptyUI();
          }
          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }
}
//   Widget _cartUI(BuildContext context, Map<String, dynamic> cartItem) {
//     final product = cartItem['product'];
//     final firstVariation =
//         product['variations'].isNotEmpty ? product['variations'][0] : null;
//     final firstImage =
//         firstVariation != null && firstVariation['images'].isNotEmpty
//             ? firstVariation['images'][0]
//             : null;
//     final sku = firstVariation != null && firstVariation['skus'].isNotEmpty
//         ? firstVariation['skus'][0]
//         : null;

//     final productId = product['product_id'] ?? 'Unknown Product';

//     final productName = product['product_name'] ?? 'Unknown Product';
//     final actualPrice = sku?['actualPrice']?.toString() ?? 'N/A';
//     final discountedPrice = sku?['discountedPrice']?.toString() ?? 'N/A';
//     final rating = product['rating'] ?? 0;

//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       elevation: 5,
//       margin: EdgeInsets.all(10),
//       child: Padding(
//         padding: EdgeInsets.all(15), // Adjust padding for better spacing
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image
//             Container(
//               width: 100,
//               height: 100,
//               decoration: BoxDecoration(
//                 borderRadius:
//                     BorderRadius.circular(10), // Rounded corners for image
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: firstImage != null
//                     ? Image.network(
//                         '${AppConstants.BASE_URL}/ProductImg/$productId/$firstImage',
//                         fit: BoxFit.cover,
//                       )
//                     : Icon(Icons.image,
//                         color: Colors.grey.shade400,
//                         size: 60), // Better placeholder
//               ),
//             ),
//             SizedBox(width: 15),

//             // Product Details
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Product Name
//                   Text(
//                     productName,
//                     style: GoogleFonts.aBeeZee(
//                       fontSize: 18, // Increased font size for better visibility
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   SizedBox(height: 8),

//                   // Rating Stars
//                   Row(
//                     children: List.generate(
//                       5,
//                       (index) => Icon(
//                         index < rating ? Icons.star : Icons.star_border,
//                         color: Colors.blueAccent,
//                         size: 16,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),

//                   // Product Price
//                   Row(
//                     children: [
//                       Text(
//                         '₹$actualPrice',
//                         style: TextStyle(
//                           color: Colors.black54,
//                           decoration: TextDecoration.lineThrough,
//                           fontSize: 14,
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Text(
//                         '₹$discountedPrice',
//                         style: TextStyle(
//                           color: Colors.green,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),

//                   // Delivery Information
//                   Text(
//                     'Free Delivery by Sept 18',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(height: 12),

//                   // Action Buttons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: _cartButton('Remove', Colors.red, () {
//                           // Remove action
//                         }),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: _cartButton('Buy Now', Colors.blueAccent, () {
//                           // Buy Now action
//                         }),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _cartButton(String text, Color color, VoidCallback onPressed) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       child: Text(text),
//       style: ElevatedButton.styleFrom(
//         foregroundColor: Colors.white,
//         backgroundColor: color,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         minimumSize: Size(80, 35),
//       ),
//     );
//   }
// }

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

  final productId = product['product_id'] ?? 'Unknown Product';
  final productName = product['product_name'] ?? 'Unknown Product';
  final actualPrice = sku?['actualPrice']?.toString() ?? 'N/A';
  final discountedPrice = sku?['discountedPrice']?.toString() ?? 'N/A';
  final rating = product['rating'] ?? 0;

  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    elevation: 5,
    margin: const EdgeInsets.symmetric(
        vertical: 10, horizontal: 15), // Adjusted margin
    child: Padding(
      padding: EdgeInsets.all(15), // Adequate padding for card content
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Section
              Container(
                width: 90,
                height: 120, // Adjusted size to match image ratio
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(8), // Small curve for image
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: firstImage != null
                      ? Image.network(
                          '${AppConstants.BASE_URL}/ProductImg/$productId/$firstImage',
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.image,
                          color: Colors.grey.shade400,
                          size: 60,
                        ), // Placeholder icon for missing image
                ),
              ),
              const SizedBox(width: 15), // Spacing between image and details

              // Product Details Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Star Rating
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.lightBlueAccent, // Light blue stars
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Price Information
                    Row(
                      children: [
                        Text(
                          '₹$actualPrice',
                          style: const TextStyle(
                            color: Colors.black54,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '₹$discountedPrice',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    const Row(
                      children: [
                        Text(
                          'Delivery by Sept 18',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Free Delivery',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _cartActionButton(
                icon: Icons.delete_outline,
                label: 'Remove',
                color: Colors.red,
                onPressed: () {},
              ),
              _cartActionButton(
                icon: Icons.flash_on,
                label: 'Buy this now',
                color: Colors.blueAccent,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _cartActionButton({
  required IconData icon,
  required String label,
  required Color color,
  required VoidCallback onPressed,
}) {
  return Expanded(
    child: TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color, size: 20),
      label: Text(
        label,
        style:
            TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide(color: Colors.grey.shade300),
      ),
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
