import 'package:dil_hack_e_commerce/api/products.dart';
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
    futureProducts = ProductService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
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
          print(products);

          return CustomScrollView(
            slivers: [
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.47,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
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
                    final discount = skus.isNotEmpty ? skus.first.discount : 0;

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
                                    builder: (context) =>
                                        // ProductDetailpage(product: product),
                                        ProductDetailPage(product: product)),
                              );
                            },
                            child: imageUrl.isNotEmpty
                                ? Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    height: 300,
                                    width: double.infinity,
                                  )
                                : Container(
                                    height: 300,
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
                                      fontSize: 15),
                                ),
                                Text(
                                  '₹$formattedPrice',
                                  style:
                                      GoogleFonts.aBeeZee(color: Colors.green),
                                ),
                                Text(
                                  'Discount: $formattedDiscount%',
                                  style: GoogleFonts.aBeeZee(color: Colors.red),
                                ),
                                Text('Free Delivery',
                                    style: GoogleFonts.aBeeZee()),
                              ],
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
      ),
    );
  }
}
