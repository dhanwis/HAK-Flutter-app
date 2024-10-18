import 'package:dil_hack_e_commerce/api/productByCategory.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/getProductByCategorybloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/getProductByCategorystate.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/wishlist_button.dart';
import 'package:dil_hack_e_commerce/features/pages/WishList/wish_list.dart';
import 'package:dil_hack_e_commerce/features/pages/cart/cart_page.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/filtering_section.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/product_detailpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsByCategory extends StatefulWidget {
  final String categoryId;
  final String categoryName = "Category";

  ProductsByCategory({Key? key, required this.categoryId}) : super(key: key);

  @override
  State<ProductsByCategory> createState() => _ProductsByCategoryState();
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  late ProductByCategoryBloc _productByCategoryBloc;

  @override
  void initState() {
    super.initState();
    _productByCategoryBloc = ProductByCategoryBloc(GetProductsByCategory());
  }

  @override
  void dispose() {
    _productByCategoryBloc
        .close(); // Close the bloc when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => _productByCategoryBloc,
      child: Scaffold(
        body: BlocBuilder<ProductByCategoryBloc, ProductByCategoryState>(
          builder: (context, state) {
            if (state is ProductByCategoryLoading) {
              return _buildSkeletonLoader(); // Show skeleton loader while loading
            } else if (state is ProductByCategoryError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is ProductByCategoryLoaded) {
              final products = state.products; // Get the loaded products

              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    title: Text(
                      widget.categoryName,
                      style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.favorite),
                        color: Colors.red,
                        iconSize: 20,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WishlistPage()),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        color: Colors.black,
                        iconSize: 20,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartPage()),
                          );
                        },
                      ),
                    ],
                  ),
                  // SliverToBoxAdapter(
                  //   child: FilterSection(),
                  // ),
                ],
                body: LayoutBuilder(
                  builder: (context, constraints) {
                    final gridWidth = constraints.maxWidth;
                    final crossAxisCount = gridWidth > 600 ? 3 : 2;
                    final childAspectRatio = gridWidth > 600 ? 0.6 : 0.55;

                    return CustomScrollView(
                      slivers: [
                        SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: childAspectRatio,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final product = products[index];
                              final firstVariation =
                                  product.variations.isNotEmpty
                                      ? product.variations.first
                                      : null;
                              final imageUrl =
                                  firstVariation?.images.isNotEmpty == true
                                      ? firstVariation!.images.first
                                      : '';
                              final skus = firstVariation?.skus ?? [];
                              final actualPrice =
                                  skus.isNotEmpty ? skus.first.actualPrice : 0;
                              final discount =
                                  skus.isNotEmpty ? skus.first.discount : 0;

                              final formattedPrice =
                                  NumberFormat('#,##0').format(actualPrice);
                              final formattedDiscount =
                                  NumberFormat('#,##0').format(discount);
                              double discountAmount =
                                  (actualPrice * discount) / 100;

                              double discountedPrice =
                                  actualPrice - discountAmount;

                              int discountedPriceInt = discountedPrice.toInt();

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
                                                  builder: (context) =>
                                                      ProductDetailPage(
                                                          productId:
                                                              product.id)),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                            child: imageUrl.isNotEmpty
                                                ? Image.network(
                                                    imageUrl,
                                                    fit: BoxFit.cover,
                                                    height: screenSize.height *
                                                        0.28,
                                                    width: double.infinity,
                                                  )
                                                : Container(
                                                    height: screenSize.height *
                                                        0.25,
                                                    width: double.infinity,
                                                    color: Colors.grey[200],
                                                    child:
                                                        const Icon(Icons.image),
                                                  ),

                                            // child: imageUrl.isNotEmpty
                                            //     ? Image.network(
                                            //         imageUrl,
                                            //         fit: BoxFit.cover,
                                            //         errorBuilder: (context, error,
                                            //             stackTrace) {
                                            //           // If the image fails to load, display a placeholder image
                                            //           return Image.asset(
                                            //             'assets/images/logo.png',
                                            //             fit: BoxFit.cover,
                                            //           );
                                            //         },
                                            //       )
                                            //     : Container(
                                            //         height:
                                            //             screenSize.height * 0.25,
                                            //         width: double.infinity,
                                            //         color: Colors.grey[200],
                                            //         child: const Icon(Icons.image),
                                            //       ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.productName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.aBeeZee(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                          // const SizedBox(height: 4.0),
                                          Text(
                                            '₹$formattedPrice',
                                            style: GoogleFonts.aBeeZee(
                                              fontSize: 12.0,
                                              color: Colors.black,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                          const SizedBox(height: 2.0),
                                          Text(
                                            '₹$discountedPriceInt with 1 Special Offer',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.aBeeZee(
                                              fontSize: 11.0,
                                              color: Colors.green,
                                            ),
                                          ),
                                          const SizedBox(height: 2.0),
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 2.0,
                                                  horizontal: 4.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text(
                                                      '4.0',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11.0,
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
                            childCount: products.length,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }
            return Container(); // Fallback in case of an unexpected state
          },
        ),
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    final screenSize = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        final gridWidth = constraints.maxWidth;
        final crossAxisCount = gridWidth > 600 ? 3 : 2;
        final itemHeight = screenSize.height * 0.28;

        return CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.6,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildSkeletonCard(itemHeight),
                childCount: 6,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSkeletonCard(double height) {
    return Skeletonizer(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use a flexible height for the image container
            Flexible(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0)),
                ),
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 15,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    width: double.infinity,
                    height: 15,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    width: 80,
                    height: 15,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: 40,
                    height: 15,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeleton() {
    final screenSize = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        final gridWidth = constraints.maxWidth;
        final crossAxisCount = gridWidth > 600 ? 3 : 2;

        return CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.6,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    _buildSkeletonCard(screenSize.height * 0.28),
                childCount: 6,
              ),
            ),
          ],
        );
      },
    );
  }
}
