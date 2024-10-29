import 'dart:developer';
import 'package:dil_hack_e_commerce/api/products_api.dart';
import 'package:dil_hack_e_commerce/constants/decodeJwt.dart';
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
  bool isLoading = true;
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
      Map<String, dynamic> decodedToken = await decodeJwt();
      setState(() {
        userId = decodedToken['userId'];
      });
    } catch (e) {}
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
    }
  }

  Widget _buildSkeletonLoader(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        itemCount: 6,
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
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.02,
                        width: MediaQuery.of(context).size.width * 0.3,
                        color: Colors.grey[300],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.02,
                        width: MediaQuery.of(context).size.width * 0.15,
                        color: Colors.grey[300],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.02,
                        width: MediaQuery.of(context).size.width * 0.25,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemCount: products.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index == products.length) {
          return Center(
            child: SpinKitFadingCircle(
              color: Color(0xFFFAAAB1),
              size: screenWidth * 0.1,
            ),
          );
        }

        final product = products[index];
        final firstVariation =
            product.variations.isNotEmpty ? product.variations.first : null;
        final imageUrl = firstVariation?.images.isNotEmpty == true
            ? firstVariation!.images.first
            : '';
        final skus = firstVariation?.skus ?? [];
        final actualPrice = skus.isNotEmpty ? skus.first.actualPrice : 0;
        final discountedPrice =
            skus.isNotEmpty && skus.first.discountedPrice != null
                ? skus.first.discountedPrice
                : null;

        final formattedPrice = NumberFormat('#,##0').format(actualPrice);
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
                          builder: (context) =>
                              ProductDetailPage(productId: product.id),
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
                              height: screenHeight * 0.25,
                              width: double.infinity,
                            )
                          : Container(
                              height: screenHeight * 0.25,
                              width: double.infinity,
                              color: Colors.grey[200],
                              child: Icon(Icons.image, size: screenWidth * 0.1),
                            ),
                    ),
                  ),
                  Positioned(
                    right: 8.0,
                    top: 10.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: screenWidth * 0.04,
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
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹$formattedPrice',
                      style: GoogleFonts.aBeeZee(
                        fontSize: screenWidth * 0.03,
                        color: Colors.black,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    if (formattedDiscount.isNotEmpty)
                      Text(
                        '₹$formattedDiscount with 1 Special Offer',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.aBeeZee(
                          fontSize: screenWidth * 0.03,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    Row(
                      children: [
                        Text(
                          "Free Delivery",
                          style: GoogleFonts.aBeeZee(
                            fontSize: screenWidth * 0.026,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.003,
                            horizontal: screenWidth * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '4.0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.03,
                                ),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: screenWidth * 0.03,
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
