import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:dil_hack_e_commerce/api/productlistbyOffer_api.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/product_detailpage.dart';

class ProductByOffercarousel extends StatefulWidget {
  final List<String> productIds;

  ProductByOffercarousel({Key? key, required this.productIds})
      : super(key: key);

  @override
  State<ProductByOffercarousel> createState() => _ProductByOffercarouselState();
}

class _ProductByOffercarouselState extends State<ProductByOffercarousel> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts =
        GetProductListByOffer().fetchProductsByIds(widget.productIds);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products by Offer',
          style: GoogleFonts.aBeeZee(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
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
                        final discountedPrice = skus.isNotEmpty &&
                                skus.first.discountedPrice != null
                            ? skus.first.discountedPrice
                            : null;

                        final formattedPrice =
                            NumberFormat('#,##0').format(actualPrice);
                        final formattedDiscount =
                            NumberFormat('#,##0').format(discountedPrice);

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
                                          : Container(
                                              height: screenSize.height * 0.25,
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
                                    SizedBox(height: 4.0),
                                    Text(
                                      '₹$formattedDiscount with 1 Special Offer',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
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
