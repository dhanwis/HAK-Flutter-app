import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:dil_hack_e_commerce/api/products_api.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/product_detailpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProductGrid extends StatefulWidget {
  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = GetAllProductApi().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available'));
          }

          final products = snapshot.data!;

          return LayoutBuilder(
            builder: (context, constraints) {
              final gridWidth = constraints.maxWidth;
              final gridHeight = constraints.maxHeight;
              final crossAxisCount = gridWidth > 600 ? 3 : 2;
              final childAspectRatio = gridWidth > 600 ? 0.6 : 0.47;

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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetailPage(
                                            product: product)),
                                  );
                                },
                                child: imageUrl.isNotEmpty
                                    ? Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        height: screenSize.height * 0.28,
                                        width: double.infinity,
                                      )
                                    : Container(
                                        height: screenSize.height * 0.25,
                                        width: double.infinity,
                                        color: Colors.grey[200],
                                        child: Icon(Icons.image),
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.productName,
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.bold,
                                          fontSize: gridWidth * 0.035),
                                    ),
                                    Text(
                                      '₹$formattedPrice',
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.green,
                                          fontSize: gridWidth * 0.03),
                                    ),
                                    Text(
                                      'Discount: $formattedDiscount%',
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.red,
                                          fontSize: gridWidth * 0.03),
                                    ),
                                    Text('Free Delivery',
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: gridWidth * 0.03)),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.favorite_border),
                                    color: Colors.red,
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.shopping_cart),
                                    onPressed: () {},
                                  ),
                                ],
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
          );
        },
      ),
    );
  }
}
