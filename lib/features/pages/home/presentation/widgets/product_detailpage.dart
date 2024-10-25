import 'package:dil_hack_e_commerce/api/productById_api.dart';
import 'package:dil_hack_e_commerce/api/similar_product_api.dart';
import 'package:dil_hack_e_commerce/api/userProfile_api.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/ProductDetail/product_detail_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/model/address.dart';

import 'package:dil_hack_e_commerce/features/auth/model/userProfile.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/otp_page/tokenStorage.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/cart_button.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/sizeSelector.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/viewall_button.dart';

import 'package:dil_hack_e_commerce/features/pages/home/presentation/order_screen.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/addressPage.dart';
import 'package:dil_hack_e_commerce/features/pages/user_review/ratingreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedVariationIndex = 0;
  int selectedSkuIndex = 0;
  Future<String> getUserId() async {
    try {
      final TokenStorage tokenStorage = TokenStorage();
      final accessToken = await tokenStorage.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception("Access token not found");
      }

      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      String userId =
          decodedToken['userId']; // Adjust based on your JWT structure
      return userId; // Return the user ID
    } catch (e) {
      print('Failed to decode JWT: $e');
      return ""; // Return an empty string or handle as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    final ApiService apiService =
        ApiService(); // Create an instance of ApiService

    final height = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => ProductDetailBloc(
                    productApi: ProductbyidApi(),
                    similarProductsApi: GetSimilarProductsApi(),
                  )..add(FetchProductDetails(widget.productId))),
          //  BlocProvider(create: (context) => CartBloc(CartService())),
        ],
        child: Scaffold(
          body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              if (state is ProductDetailLoading) {
                return SkeletonLoader();
              } else if (state is ProductDetailLoaded) {
                final actualPrice =
                    state.product.variations.first.skus.isNotEmpty
                        ? state.product.variations[selectedVariationIndex]
                            .skus[0].actualPrice
                        : 0;
                final discountedPrice =
                    state.product.variations.first.skus.isNotEmpty
                        ? state.product.variations[selectedVariationIndex]
                            .skus[selectedSkuIndex].discountedPrice
                        : null;

                final formattedPrice =
                    NumberFormat('#,##0').format(actualPrice);
                final formattedDiscount = discountedPrice != null
                    ? NumberFormat('#,##0').format(discountedPrice)
                    : '';

                List<String> sizes = state.product.variations.isNotEmpty
                    ? state.product.variations[selectedVariationIndex].skus
                        .map((sku) => sku.size)
                        .toList()
                    : [];

                return ListView(
                  children: [
                    Container(
                      height: height * 0.6,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state
                            .product
                            .variations[selectedVariationIndex]
                            .images
                            .length, // Display images from the selected variation
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: height * 0.6,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                state.product.variations[selectedVariationIndex]
                                        .images[
                                    index], // Show image from the selected variation
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/logo.png', // Your fallback image asset
                                    fit: BoxFit.cover,
                                  );
                                },
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
                                fontSize: 13,
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
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          if (formattedDiscount.isNotEmpty)
                            Text(
                              '  ₹$formattedDiscount with 1 Special Offer',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: GoogleFonts.aBeeZee(
                                fontSize: 15.0,
                                color: Colors.green,
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Horizontal Scroll for Variations (Color/Size, etc.)
                    if (state.product.variations.length > 1)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              state.product.variations.length,
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // Update the selected variation index to reflect the chosen variation
                                      selectedVariationIndex = index;
                                      selectedSkuIndex = 0;
                                    });
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      state.product.variations[index].images
                                          .first, // Display image of each variation
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
                          Row(
                            children: List.generate(
                              sizes.length,
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSkuIndex =
                                          index; // Update selected SKU index
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 14),
                                    decoration: BoxDecoration(
                                      color: selectedSkuIndex == index
                                          ? Palette.appTheme
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        if (selectedSkuIndex == index)
                                          BoxShadow(
                                            color: Palette.appTheme
                                                .withOpacity(0.4),
                                            blurRadius: 8,
                                            offset:
                                                Offset(0, 4), // Shadow position
                                          ),
                                      ],
                                    ),
                                    child: Text(
                                      sizes[index],
                                      style: TextStyle(
                                        color: selectedSkuIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                            ? state.product.variations[selectedVariationIndex]
                                .color.value // Access only the value
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
                                state.product.variations[selectedVariationIndex]
                                    .skus.isNotEmpty
                            ? state.product.variations[selectedVariationIndex]
                                .skus[0].quantity
                                .toString()
                            : 'N/A',
                      ),
                    ),

                    if (state.similarProducts.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Similar Products',
                                    style: GoogleFonts.aBeeZee(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ViewAllButton(
                                              products: state.similarProducts),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'View All',
                                      style: GoogleFonts.aBeeZee(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 240,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.similarProducts.length,
                                itemBuilder: (context, index) {
                                  print(
                                      'state.similarProducts.length ${state.similarProducts.length}');

                                  // Ensure we access variations safely
                                  if (state.similarProducts[index].variations
                                      .isNotEmpty) {
                                    String imageUrl = state
                                            .similarProducts[index]
                                            .variations[0]
                                            .images[
                                        0]; // Access the first variation
                                    String formattedPrice =
                                        NumberFormat('#,##0').format(state
                                            .similarProducts[index]
                                            .variations[0]
                                            .skus[0]
                                            .actualPrice);

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailPage(
                                              productId: state
                                                  .similarProducts[index].id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Image.network(
                                                  imageUrl,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                state.similarProducts[index]
                                                    .productBrand,
                                                style: GoogleFonts.aBeeZee(
                                                  color: Colors.grey,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 1),
                                              child: Text(
                                                state.similarProducts[index]
                                                    .productName
                                                    .toUpperCase(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.aBeeZee(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '₹ $formattedPrice',
                                              style: GoogleFonts.aBeeZee(
                                                color: Colors.green,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return SizedBox
                                        .shrink(); // Return an empty widget if no variations
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RatingAndReviews(),
                    ),
                    // const Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: ReviewPage(),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: AddToCartButtonState(
                              productId: widget.productId,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  // Get user ID from the JWT
                                  String userId = await getUserId();

                                  if (userId.isEmpty) {
                                    throw Exception("User ID not found.");
                                  }

                                  CustomerProfile loggedInUser =
                                      await apiService.getProfileData(userId);

                                  List<Address> addresses = loggedInUser
                                      .addresses!
                                      .map<Address>((address) =>
                                          Address.fromJson(address))
                                      .toList();

                                  if (addresses.isNotEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderScreen(
                                          profile: loggedInUser,
                                          address: addresses
                                              .first, // Existing address
                                          product:
                                              state.product, // Pass the product

                                          variantId: state
                                              .product
                                              .variations[
                                                  selectedVariationIndex]
                                              .id,
                                          skuId: state
                                              .product
                                              .variations[
                                                  selectedVariationIndex]
                                              .skus[selectedSkuIndex]
                                              .id,
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddressFormPage(
                                          product: state.product,
                                          variantId: state
                                              .product
                                              .variations[
                                                  selectedVariationIndex]
                                              .id,
                                          skuId: state
                                              .product
                                              .variations[
                                                  selectedVariationIndex]
                                              .skus[selectedSkuIndex]
                                              .id,
                                        ),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Failed to retrieve user data: $e'),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Buy Now',
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFAAAB1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                              ),
                            ),
                          )
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
              return Container();
            },
          ),
        ));
    // BlocProvider(
    //   create: (context) => ProductDetailBloc(
    //     productApi: ProductbyidApi(),
    //     similarProductsApi: GetSimilarProductsApi(),
    //   )..add(FetchProductDetails(productId)),
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
            5,
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
