import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/product_detailpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart'; // Import the skeletonizer package
import 'package:dil_hack_e_commerce/api/productByCategory.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:intl/intl.dart';

class ProductsByCategory extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  ProductsByCategory(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);

  @override
  State<ProductsByCategory> createState() => _ProductsByCategoryState();
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  late Future<List<Product>> futureProductsByCategory;

  @override
  void initState() {
    super.initState();
    futureProductsByCategory = GetProductsByCategory()
        .fetchProductByCategoryId(widget.categoryId) as Future<List<Product>>;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<List<Product>>(
        future: futureProductsByCategory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show skeleton loader while waiting for data
            return _buildSkeletonLoader();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available'));
          }

          final products = snapshot.data!;

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                title: Text(
                  '${widget.categoryName}',
                  style: GoogleFonts.aBeeZee(
                    fontWeight: FontWeight.bold,
                    // child:floating: true,
                    // snap: true,
                  ),
                ),
              ),
            ],
            body: LayoutBuilder(
              builder: (context, constraints) {
                final gridWidth = constraints.maxWidth;
                final crossAxisCount = gridWidth > 600 ? 3 : 2;
                final childAspectRatio = gridWidth > 600 ? 0.6 : 0.55;

                return CustomScrollView(
                  slivers: [
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: childAspectRatio,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product = products[index];
                          final firstVariation = product.variations.isNotEmpty
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
                                                      product: product)),
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
                                                height:
                                                    screenSize.height * 0.28,
                                                width: double.infinity,
                                              )
                                            : Container(
                                                height:
                                                    screenSize.height * 0.25,
                                                width: double.infinity,
                                                color: Colors.grey[200],
                                                child: Icon(Icons.image),
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 10.0,
                                      top: 10.0,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 15,
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 20,
                                          ),
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
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        '₹$formattedPrice',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        '₹$formattedDiscount with 1 Special Offer',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.green,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
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
                                          SizedBox(width: 5.0),
                                          Text(
                                            '(1200)',
                                            style: TextStyle(
                                              fontSize: 12.0,
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
        },
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    final screenSize = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        final gridWidth = constraints.maxWidth;
        final crossAxisCount = gridWidth > 600 ? 3 : 2;
        final itemHeight = screenSize.height * 0.28; // Adjust height as needed

        return CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.6, // Adjust aspect ratio as needed
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildSkeletonCard(itemHeight),
                childCount:
                    6, // Adjust this number based on expected product count
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
            Container(
              color: Colors.grey[200],
              height: height,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey[200],
                    height: 20,
                    width: 100,
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    color: Colors.grey[200],
                    height: 15,
                    width: 80,
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    color: Colors.grey[200],
                    height: 15,
                    width: 120,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
