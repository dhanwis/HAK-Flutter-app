import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_state.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/wishlist_button.dart';
import 'package:dil_hack_e_commerce/features/pages/WishList/skeltonContainer.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/productPage.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/product_detailpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:skeletonizer/skeletonizer.dart';

class WishlistView extends StatefulWidget {
  @override
  _WishlistViewState createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  @override
  void initState() {
    super.initState();

    // Make sure to add the FetchWishlistItems event when the widget is initialized
    context.read<WishlistBloc>().add(FetchWishlistItems());
  }

  @override
  Widget build(BuildContext context) {
    return WishlistPage();
  }
}

class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wishlist",
          style: GoogleFonts.aBeeZee(
              fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            // Show the loading indicator while the wishlist is being fetched
            return _buildProductCardSkeleton(
                context, MediaQuery.of(context).size.height);
          } else if (state is WishlistLoaded) {
            // Show the wishlist items when they are loaded
            if (state.wishlist.isEmpty) {
              return _emptyUI(context);
              //return Center(child: Text("No items in your wishlist"));
            }

            return GridView.builder(
              itemCount: state.wishlist.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.55,
              ),
              itemBuilder: (context, index) {
                final product = state.wishlist[index];
                final screenHeight = MediaQuery.of(context).size.height;
                return _buildProductCard(context, product, screenHeight);
              },
            );
          } else if (state is WishlistError) {
            // Show an error message if there's an error fetching the wishlist
            return _emptyUI(context);
          }
          return Center(child: Text("Something went wrong on wislist !"));
        },
        //enna k
      ),
    );
  }

  // Skeleton loader widget
  Widget _buildProductCardSkeleton(BuildContext context, double screenHeight) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Skeletonizer(
          enabled:
              true, // Set this to 'true' while loading and 'false' when data is available
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section skeleton
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: SkeletonContainer(
                  height: screenHeight * 0.28,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(10.0),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 10),
              // Skeleton for product details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name skeleton
                  SkeletonContainer(
                      height: 12.0,
                      width: 150.0,
                      borderRadius: BorderRadius.circular(4),
                      shape: BoxShape.circle),
                  const SizedBox(height: 6),
                  // Actual price skeleton
                  SkeletonContainer(
                      height: 12.0,
                      width: 80.0,
                      borderRadius: BorderRadius.circular(4),
                      shape: BoxShape.circle),
                  const SizedBox(height: 6),
                  // Discounted price skeleton
                  SkeletonContainer(
                      height: 12.0,
                      width: 120.0,
                      borderRadius: BorderRadius.circular(4),
                      shape: BoxShape.circle),
                  const SizedBox(height: 10),
                  // Rating row skeleton
                  Row(
                    children: [
                      SkeletonContainer(
                        height: 12.0,
                        width: 40.0,
                        borderRadius: BorderRadius.circular(4),
                        shape: BoxShape.circle,
                      ),
                      const SizedBox(width: 4),
                      SkeletonContainer(
                        height: 12.0,
                        width: 12.0,
                        shape: BoxShape.circle,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyUI(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: Lottie.asset(
              'assets/images/wishlistlottie.json',
              height: 180,
              width: 180,
            ),
          ),
          Center(
            child: Text("Your Wishlist Is Empty !",
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    color: Colors.grey.shade500,
                    fontSize: 15)),
          ),
          SizedBox(
            height: 20,
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 120, right: 120),
            child: ElevatedButton(
              child: const Text(
                'Shop Now',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductGrid(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFAAAB1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Product card widget
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
                          height: screenHeight * 0.28,
                          width: double.infinity,
                          // fit: BoxFit.cover,
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
                              fontSize: 12.0,
                            ),
                          ),
                          const Icon(
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
