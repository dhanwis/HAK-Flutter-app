import 'package:dil_hack_e_commerce/api/products_api.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/product_detailpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import for NumberFormat

class ProductGrid extends StatefulWidget {
  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  List<Product> products = [];
  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMoreProducts = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchProducts();
      }
    });
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
      print('Error fetching products: $e');
    } finally {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final gridWidth = constraints.maxWidth;
          final crossAxisCount = gridWidth > 600 ? 3 : 2;
          final childAspectRatio = gridWidth > 600 ? 0.6 : 0.55;

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == products.length) {
                      if (isLoadingMore) {
                        return Center(child: CircularProgressIndicator());
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
                                right: 10.0,
                                top: 10.0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15,
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.black,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.productName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  '₹$formattedPrice',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                if (formattedDiscount.isNotEmpty)
                                  Text(
                                    '₹$formattedDiscount with 1 Special Offer',
                                    style: TextStyle(
                                      fontSize: 14.0,
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
                                      '(12000)',
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
                  childCount: products.length + (isLoadingMore ? 1 : 0),
                ),
              ),
              if (isLoadingMore)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
