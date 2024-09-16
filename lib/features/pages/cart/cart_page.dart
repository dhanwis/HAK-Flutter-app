// import 'dart:ui';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dil_hack_e_commerce/features/pages/account/account_page.dart';
// import 'package:dil_hack_e_commerce/features/pages/home/presentation/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:lottie/lottie.dart';

// class CartPage extends StatefulWidget {
//   const CartPage({super.key});

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.arrow_back),
//         ),
//         centerTitle: true,
//         title: Text(
//           "Cart",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Color(0xFFFAAAB1),
//       ),
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 180),
//             child: Lottie.asset(
//               'assets/images/Animation - 1717999632927 (1).json',
//               height: 200,
//               width: 200,
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Center(
//             child: Text("Your Cart Is Empty !",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w200,
//                     color: Colors.grey.shade500,
//                     fontSize: 15)),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 100, right: 100),
//             child: ElevatedButton(
//               child: const Text(
//                 'Shop Now',
//                 style: TextStyle(color: Colors.black),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AccountPage(),
//                     ));
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFFAAAB1),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:dil_hack_e_commerce/features/pages/home/presentation/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
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
                            Image.asset(
                              'assets/products/pr8.jpeg',
                              width: screenWidth * 0.25,
                              height: screenWidth * 0.25,
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Boys Printed Cotton Blend Regular T-Shirt (Blue)',
                                    style: GoogleFonts.aBeeZee(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.04,
                                    ),
                                  ),
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
                                        '₹899',
                                        style: GoogleFonts.aBeeZee(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.02),
                                      Text(
                                        '₹499',
                                        style: GoogleFonts.aBeeZee(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.045,
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
                                    DropdownMenuItem(
                                        value: 1, child: Text('1')),
                                    DropdownMenuItem(
                                        value: 2, child: Text('2')),
                                    DropdownMenuItem(
                                        value: 3, child: Text('3')),
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
                                  color:
                                      const Color.fromARGB(255, 92, 92, 92))),
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
                      '₹499.00',
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
}
