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

import 'package:dil_hack_e_commerce/api/wishList_api.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class WishlistPage extends StatelessWidget {
  final String userId;

  const WishlistPage({Key? key, required this.userId}) : super(key: key);

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
      body: BlocProvider(
        create: (context) =>
            WishlistBloc(WishlistService())..add(FetchWishlist(userId)),
        child: WishlistView(userId: userId),
      ),
    );
  }
}

class WishlistView extends StatelessWidget {
  final String userId;

  const WishlistView({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(
      builder: (context, state) {
        if (state is WishlistLoading) {
          print('loading');
          return Center(child: CircularProgressIndicator());
        } else if (state is WishlistLoaded) {
          print('is loaded');
          return ListView.builder(
            itemCount: state.wishlist.length,
            itemBuilder: (context, index) {
              final product = state.wishlist[index];
              print('all product');
              print(product);

              return ListTile(
                title: Text(product['name']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    BlocProvider.of<WishlistBloc>(context)
                        .add(RemoveFromWishlist(userId, product['_id']));
                  },
                ),
              );
            },
          );
        } else if (state is WishlistError) {
          print('error hae');
          return Center(child: Text(state.message));
        } else {
          print('No Wishlist Found');
          return Center(child: Text('No Wishlist Found'));
        }
      },
    );
  }
}








//  Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10.0),
//                   topRight: Radius.circular(10.0),
//                 ),
//                 child: Image.asset(
//                   product.variations.first.images.first,
//                   height: 180,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned(
//                 right: 10.0,
//                 top: 10.0,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   radius: 12,
//                   child: Icon(
//                     Icons.favorite_border,
//                     color: Colors.black,
//                     size: 18,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   product.productName,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                   style: TextStyle(
//                     fontSize: 12.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 // SizedBox(height: 4.0),
//                 Text(
//                   product.variations.first.skus.first.actualPrice,
//                   style: TextStyle(
//                     fontSize: 12.0,
//                     color: Colors.black,
//                     decoration: TextDecoration.lineThrough,
//                   ),
//                 ),
//                 SizedBox(height: 1.0),
//                 Text(
//                   product.variations.first.skus.first.discountedPrice,
//                   style: TextStyle(
//                     fontSize: 10.0,
//                     color: Colors.green,
//                   ),
//                 ),
//                 SizedBox(height: 8.0),
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 2.0,
//                         horizontal: 4.0,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(4.0),
//                       ),
//                       child: Row(
//                         children: [
//                           Text(
//                             product.rating.toString(),
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12.0,
//                             ),
//                           ),
//                           Icon(
//                             Icons.star,
//                             color: Colors.white,
//                             size: 12.0,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }