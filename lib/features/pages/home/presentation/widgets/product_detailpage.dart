import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:dil_hack_e_commerce/api/productById_api.dart';
import 'package:dil_hack_e_commerce/api/similar_product_api.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class ProductDetailPage extends StatefulWidget {
  final String productId;

  ProductDetailPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Future<Product> productFuture;
  late Future<List<Product>> similarProductsFuture;

  @override
  void initState() {
    super.initState();
    productFuture = fetchProductDetails(widget.productId);
  }

  Future<Product> fetchProductDetails(String productId) async {
    try {
      Product product = await fetchProductById(productId);
      similarProductsFuture =
          GetSimilarProductsApi().fetchSimilarProductById(product.id);
      return product;
    } catch (e) {
      print(e);
      throw Exception('Failed to load product');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final actualPrice = widget.product.variations.first.skus.first.actualPrice;
    //final formattedPrice = NumberFormat('#,##0').format(actualPrice);

    // Fetch the list of sizes from the product's variations

    // List<String> sizes = widget.product.variations.isNotEmpty
    //     ? widget.product.variations.first.skus.map((sku) => sku.size).toList()
    //     : [];

    return Scaffold(
      body: FutureBuilder<Product>(
        future: productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Product not found'));
          } else {
            final product = snapshot.data!;
            final actualPrice = product.variations.first.skus.first.actualPrice;
            final formattedPrice = NumberFormat('#,##0').format(actualPrice);

            List<String> sizes = product.variations.isNotEmpty
                ? product.variations.first.skus.map((sku) => sku.size).toList()
                : [];

            return ListView(
              children: [
                Skeletonizer(
                  enabled: product.variations.isEmpty,
                  child: Container(
                    height: height * 0.6,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product.variations.first.images.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: height * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              product.variations.first.images[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          capitalizeFirstLetter(product.productName),
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          capitalizeFirstLetter(product.productDescription),
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        '₹$formattedPrice',
                        style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Similar Products',
                    style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                // Similar products list
              ],
            );
          }
        },
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.aBeeZee(fontWeight: FontWeight.w800),
        ),
        Text(value, style: GoogleFonts.aBeeZee(fontWeight: FontWeight.w300)),
      ],
    );
  }
}

class SizeSelector extends StatefulWidget {
  final List<String> sizes;

  SizeSelector({required this.sizes});

  @override
  _SizeSelectorState createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  String selectedSize = '';

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: widget.sizes.map((size) {
        return ChoiceChip(
          label: Text(size),
          selected: selectedSize == size,
          onSelected: (selected) {
            setState(() {
              selectedSize = selected ? size : '';
            });
          },
          selectedColor: Color(0xFFFAAAB1),
          labelStyle: TextStyle(
            color: selectedSize == size ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}
