import 'dart:developer';

import 'package:dil_hack_e_commerce/api/products_api.dart';
import 'package:dil_hack_e_commerce/constants/decodeJwt.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/wishlist_button.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/product_detailpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ProductGrid extends StatefulWidget {
  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  List<Product> products = [];
  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMoreProducts = true;
  bool isLoading = true; // Initial loading state
  final ScrollController _scrollController = ScrollController();

  String userId = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _initializeUser();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        log("end of the line");
        _fetchProducts();
      }
    });
  }

  Future<void> _initializeUser() async {
    try {
      // Decode the token and get userId
      Map<String, dynamic> decodedToken = await decodeJwt();
      setState(() {
        userId = decodedToken[
            'userId']; // Assuming 'userId' is the key in your token
        // Initialize pages after userId is obtained
      });
    } catch (e) {
      print("Error decoding token: $e");
    }
  }

  Future<void> _fetchProducts() async {
    if (isLoadingMore || !hasMoreProducts) return;

    setState(() {
      isLoadingMore = true;
    });

    try {
      final newProducts =
          await GetAllProductApi().fetchProducts(page: currentPage);
      if (newProducts.isEmpty) {
        setState(() {
          hasMoreProducts = false;
        });
      } else {
        setState(() {
          products.addAll(newProducts);
          currentPage++;
        });
      }
    } catch (e) {
      // Handle error (e.g., show an error message)
    } finally {
      setState(() {
        isLoadingMore = false;
        isLoading = false; // Stop loading after fetching products
      });
    }
  }

  Widget _buildSkeletonLoader(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        itemCount: 6, // Show 6 skeleton items initially
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
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
                      SizedBox(height: 8.0),
                      Container(
                        height: 16.0,
                        width: 50.0,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 8.0),
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SliverGrid.builder(


      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(


        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemCount:    products.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
      if (index == products.length) {
        if (isLoadingMore) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Centers the column vertically
              children: [
                Center(
                    child: SpinKitFadingCircle(
                      color: Color(0xFFFAAAB1),
                      size: 40.0, // Adjust the size as needed
                    )),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      }

      final product = products[index];
      final firstVariation = product.variations.isNotEmpty
          ? product.variations.first
          : null;
      final imageUrl = firstVariation?.images.isNotEmpty == true
          ? firstVariation!.images.first
          : '';
      final skus = firstVariation?.skus ?? [];
      final actualPrice =
      skus.isNotEmpty ? skus.first.actualPrice : 0;
      final discountedPrice =
      skus.isNotEmpty && skus.first.discountedPrice != null
          ? skus.first.discountedPrice
          : null;

      final formattedPrice =
      NumberFormat('#,##0').format(actualPrice);
      final formattedDiscount = discountedPrice != null
          ? NumberFormat('#,##0').format(discountedPrice)
          : '';

      return Card(
        color: Colors.white,
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
                            productId: product.id),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: imageUrl.isNotEmpty
                        ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: screenSize.height * 0.28,
                      width: double.infinity,
                    )
                        : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: screenSize.height * 0.25,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: Icon(Icons.image),
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
                    child: FavoriteButton(
                      productId: product.id,
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
                    product.productName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.aBeeZee(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹$formattedPrice',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  if (formattedDiscount.isNotEmpty)
                    Text(
                      '₹$formattedDiscount with 1 Special Offer',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.green,
                      ),
                    ),
                  SizedBox(height: 3.0),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius:
                          BorderRadius.circular(4.0),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '4.0',
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
    },
    );
  }
}
