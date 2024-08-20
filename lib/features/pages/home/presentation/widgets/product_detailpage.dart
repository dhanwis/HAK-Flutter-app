import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/ratingreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    similarProductsFuture =
        GetSimilarProductsApi().fetchSimilarProductById(widget.productId);
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
    //final actualPrice = productFuture.variations.first.skus.first.actualPrice;
    //final formattedPrice = NumberFormat('#,##0').format(actualPrice);

    // Fetch the list of sizes from the product's variations

    // List<String> sizes = widget.productId.variations.isNotEmpty
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
              final actualPrice =
                  product.variations.first.skus.first.actualPrice;
              final formattedPrice = NumberFormat('#,##0').format(actualPrice);

              List<String> sizes = product.variations.isNotEmpty
                  ? product.variations.first.skus
                      .map((sku) => sku.size)
                      .toList()
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
                  FutureBuilder<List<Product>>(
                    future: similarProductsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Skeletonizer(
                          enabled: true,
                          child: Center(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                            child: Text('No similar products found.'));
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              snapshot.data!.length,
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: GestureDetector(
                                  onTap: () => fetchProductDetails(
                                      snapshot.data![index].id),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(snapshot
                                        .data![index]
                                        .variations
                                        .first
                                        .images
                                        .first),
                                    backgroundColor: Colors.grey.shade200,
                                    radius: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 20,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.green,
                      ),
                      onRatingUpdate: (index) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Size',
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizeSelector(sizes: sizes), // Pass sizes list here
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Product Details',
                      style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: DetailRow(
                  //     label: 'Color',
                  //     value: widget.product.variations.isNotEmpty &&
                  //             widget.product.variations.first.color.isNotEmpty
                  //         ? widget.product.variations.first.color
                  //         : 'N/A',
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: DetailRow(
                  //     label: 'Weight',
                  //     value: widget.product.productWeight.toString(),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: DetailRow(
                  //     label: 'Brand',
                  //     value: widget.product.productBrand,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: DetailRow(
                  //     label: 'Type',
                  //     value: widget.product.productType,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: DetailRow(
                  //     label: 'Publish Date',
                  //     value: DateFormat('dd-MM-yyyy')
                  //         .format(widget.productId.productPublishDatetime),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: DetailRow(
                  //     label: 'Total Stock',
                  //     value: widget.product.variations.isNotEmpty &&
                  //             widget.product.variations[0].skus.isNotEmpty
                  //         ? widget.product.variations[0].skus[0].quantity.toString()
                  //         : 'N/A',
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RatingAndReviews(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                          ),
                          label: Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              color: Color(0xFFFAAAB1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.double_arrow, color: Colors.black),
                          label: Text(
                            'Buy Now',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFAAAB1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 34, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
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
