// // // import 'dart:ui';

// // // import 'package:carousel_slider/carousel_slider.dart';
// // // import 'package:dil_hack_e_commerce/features/pages/account/account_page.dart';
// // // import 'package:dil_hack_e_commerce/features/pages/home/presentation/home_page.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter/widgets.dart';
// // // import 'package:lottie/lottie.dart';

// // // class FavPage extends StatefulWidget {
// // //   const FavPage({super.key});

// // //   @override
// // //   State<FavPage> createState() => _FavPageState();
// // // }

// // // class _FavPageState extends State<FavPage> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final height = MediaQuery.of(context).size.height;
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         leading: IconButton(
// // //           onPressed: () {
// // //             Navigator.push(
// // //               context,
// // //               MaterialPageRoute(builder: (context) => HomePage()),
// // //             );
// // //           },
// // //           icon: const Icon(Icons.arrow_back),
// // //         ),
// // //         centerTitle: true,
// // //         title: Text(
// // //           "Cart",
// // //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
// // //         ),
// // //         backgroundColor: Color(0xFFFAAAB1),
// // //       ),
// // //       body: ListView(
// // //         children: [
// // //           Padding(
// // //             padding: const EdgeInsets.only(top: 180),
// // //             child: Lottie.asset(
// // //               'assets/images/wishlistlottie.json',
// // //               height: 180,
// // //               width: 180,
// // //             ),
// // //           ),
// // //           Center(
// // //             child: Text("Your Wishlist Is Empty !",
// // //                 style: TextStyle(
// // //                     fontWeight: FontWeight.w200,
// // //                     color: Colors.grey.shade500,
// // //                     fontSize: 15)),
// // //           ),
// // //           SizedBox(
// // //             height: 20,
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.only(left: 120, right: 120),
// // //             child: ElevatedButton(
// // //               child: const Text(
// // //                 'Shop Now',
// // //                 style: TextStyle(color: Colors.black),
// // //               ),
// // //               onPressed: () {
// // //                 Navigator.push(
// // //                     context,
// // //                     MaterialPageRoute(
// // //                       builder: (context) => AccountPage(),
// // //                     ));
// // //               },
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: const Color(0xFFFAAAB1),
// // //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavPage extends StatefulWidget {
  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  final List<Product> products = [
    Product(
      imageUrl: 'assets/products/pr9.jpeg',
      name: "Nyra silk saree ",
      price: '₹547 ',
      offerPrice: '₹507 with 2 Special Offers',
      rating: 4.0,
      freeDelivery: true,
    ),
    Product(
      imageUrl: 'assets/products/pr7.jpeg',
      name: 'Dailywear sraee',
      price: '₹297',
      offerPrice: '₹277 with 1 Special Offer',
      rating: 3.9,
      freeDelivery: true,
    ),
    Product(
      imageUrl: 'assets/products/pr6.jpeg',
      name: 'Ready to wear ',
      price: '₹715',
      offerPrice: '₹685 with 2 Special Offers',
      rating: 3.3,
      freeDelivery: true,
    ),
    Product(
      imageUrl: 'assets/products/pr10.jpeg',
      name: ' cotton silk saree ',
      price: '₹880',
      offerPrice: '₹831 with 1 Special ',
      rating: 3.4,
      freeDelivery: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Wishlist',
          style: GoogleFonts.aBeeZee(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_add_outlined),
            color: Colors.yellow,
            iconSize: 20,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Colors.black,
            iconSize: 20,
            onPressed: () {},
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 0.6,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}

class Product {
  final String imageUrl;
  final String name;
  final String price;
  final String offerPrice;
  final double rating;

  final bool freeDelivery;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.offerPrice,
    required this.rating,
    required this.freeDelivery,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Image.asset(
                  product.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 10.0,
                top: 10.0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 12,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(height: 4.0),
                Text(
                  product.price,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(height: 1.0),
                Text(
                  product.offerPrice,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2.0,
                        horizontal: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            product.rating.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 12.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
