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

import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/wishlist_button.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/product_detailpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dil_hack_e_commerce/api/wishList_api.dart';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_state.dart';
import 'package:shimmer/shimmer.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

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
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_add),
            color: const Color.fromARGB(255, 204, 187, 35),
            iconSize: 20,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocProvider(
        // Providing WishlistBloc in the widget tree
        create: (context) => WishlistBloc(WishlistService()),
        child: const WishlistView(),
      ),
    );
  }
}

class WishlistView extends StatelessWidget {
  const WishlistView({Key? key}) : super(key: key);

  // Reusable Skeleton Loader
  Widget _buildSkeletonLoader(context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.55,
        ),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.28,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16.0,
                        width: 100.0,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        height: 16.0,
                        width: 50.0,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        height: 16.0,
                        width: 80.0,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable product card builder
  Widget _buildProductCard(
      BuildContext context, Map<String, dynamic> product, double screenHeight) {
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

    final productName = product['product_name'] ?? 'Unknown Product';
    final productId = product['product_id'] ?? 'Unknown Product';
    final actualPrice = sku?['actualPrice']?.toString() ?? 'N/A';
    final discountedPrice = sku?['discountedPrice']?.toString() ?? 'N/A';
    final rating = product['rating'] ?? 10;
    final ratingCount = product['ratingCount']?.toString() ?? '0';

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                        productId: product['_id'],
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  child: firstImage != null
                      ? Image.network(
                          '${AppConstants.BASE_URL}/ProductImg/$productId/$firstImage',
                          height: screenHeight * 0.20,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: screenHeight * 0.25,
                            width: double.infinity,
                            color: Colors.grey[200],
                            child: const Icon(Icons.image),
                          ),
                        ),
                ),
              ),
              Positioned(
                right: 8.0,
                top: 10.0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 16,
                  child: FavoriteButton(productId: product['_id']),
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
                  productName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                            rating.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 5.0,
                            ),
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 10.0,
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocBuilder<WishlistBloc, WishlistState>(
      builder: (context, state) {
        print('state a');
        print(state);
        if (state is WishlistLoading) {
          return _buildSkeletonLoader(context); // Show skeleton loader
        } else if (state is WishlistLoaded) {
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.75,
            ),
            itemCount: state.wishlist.length,
            itemBuilder: (context, index) {
              final product = state.wishlist[index];
              return _buildProductCard(context, product, screenSize.height);
            },
          );
        } else if (state is WishlistError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No Wishlist Found'));
        }
      },
    );
  }
}
