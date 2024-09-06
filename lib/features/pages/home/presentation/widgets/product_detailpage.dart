import 'package:dil_hack_e_commerce/api/productById_api.dart';
import 'package:dil_hack_e_commerce/api/similar_product_api.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/ProductDetail/product_detail_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/sizeSelector.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/ratingreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({Key? key, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocProvider(
        create: (context) => ProductDetailBloc(
          productApi: ProductbyidApi(),
          similarProductsApi: GetSimilarProductsApi(),
        )..add(FetchProductDetails(productId)),
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              return SkeletonLoader();
            } else if (state is ProductDetailLoaded) {
              final actualPrice =
                  state.product.variations.first.skus.first.actualPrice;
              final formattedPrice = NumberFormat('#,##0').format(actualPrice);

              List<String> sizes = state.product.variations.isNotEmpty
                  ? state.product.variations.first.skus
                      .map((sku) => sku.size)
                      .toList()
                  : [];

              return ListView(
                children: [
                  Container(
                    height: height * 0.6,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.product.variations.first.images.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: height * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              state.product.variations.first.images[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            capitalizeFirstLetter(state.product.productName),
                            style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            //FavoriteButton(),
                            IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {
                                final String productUrl =
                                    'https://yourwebsite.com/products/${state.product.id}';
                                final String productDescription =
                                    state.product.productDescription;
                                final String shareText =
                                    '${state.product.productName}\n$productDescription\n$productUrl';
                                Share.share(shareText);
                              },
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
                            capitalizeFirstLetter(
                                state.product.productDescription),
                            style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
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
                        fontSize: 14,
                      ),
                    ),
                  ),
                  if (state.similarProducts.isEmpty)
                    SimilarProductsSkeletonLoader()
                  else
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            state.similarProducts.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailPage(
                                        productId:
                                            state.similarProducts[index].id,
                                      ),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    state.similarProducts[index].variations
                                        .first.images.first,
                                  ),
                                  backgroundColor: Colors.grey.shade200,
                                  radius: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizeSelector(sizes: sizes),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Product Details',
                      style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DetailRow(
                      label: 'Color',
                      value: state.product.variations.isNotEmpty
                          ? state.product.variations.first.color
                          : 'N/A',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DetailRow(
                      label: 'Weight',
                      value: state.product.productWeight.toString(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DetailRow(
                      label: 'Brand',
                      value: state.product.productBrand,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DetailRow(
                      label: 'Type',
                      value: state.product.productType,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DetailRow(
                      label: 'Publish Date',
                      value: DateFormat('dd-MM-yyyy')
                          .format(state.product.productPublishDatetime),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DetailRow(
                      label: 'Total Stock',
                      value: state.product.variations.isNotEmpty &&
                              state.product.variations[0].skus.isNotEmpty
                          ? state.product.variations[0].skus[0].quantity
                              .toString()
                          : 'N/A',
                    ),
                  ),
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
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Buy Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFAAAB1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is ProductDetailError) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            }
            return Container(); // Default case, should not reach here
          },
        ),
      ),
    );
  }
}

class SkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Skeletonizer(
            child: SkeletonImage(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeletonizer(
            child: SkeletonText(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeletonizer(
            child: SkeletonText(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeletonizer(
            child: SkeletonText(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeletonizer(
            child: SkeletonText(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeletonizer(
            child: SkeletonText(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeletonizer(
            child: SkeletonText(),
          ),
        ),
      ],
    );
  }
}

class SkeletonImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      height: MediaQuery.of(context).size.height * 0.6,
    );
  }
}

class SkeletonText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(vertical: 5),
    );
  }
}

class SimilarProductsSkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            5, // Number of skeleton items you want to display
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                radius: 30,
              ),
            ),
          ),
        ),
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
          style: GoogleFonts.aBeeZee(
            fontWeight: FontWeight.w800,
            fontSize: 12,
          ),
        ),
        Text(value,
            style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.w300,
              fontSize: 12,
            )),
      ],
    );
  }
}
