import 'dart:convert';
import 'package:dil_hack_e_commerce/api/newarrivels_api.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/all_products.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/categories.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/offer_carousel.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/search.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/top_row.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<NewArrivalProduct>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchNewArrivals();
  }

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      EvaIcons.google,
      EvaIcons.clock,
      EvaIcons.facebook,
      EvaIcons.inbox,
      EvaIcons.headphones,
      EvaIcons.bluetooth,
      EvaIcons.wifi,
    ];

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            backgroundColor: Colors.white,
            title: TopRow(),
          ),
          SliverAppBar(
            title: AppSearchBar(
              width: width,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Categories(
                icons: icons,
              ),
            ),
          ),
          FutureBuilder<List<NewArrivalProduct>>(
            future: futureProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(child: Text('No products found')),
                );
              } else {
                List<NewArrivalProduct> products = snapshot.data!;
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'New Arrivals',
                                style: GoogleFonts.aBeeZee(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                              Text(
                                'View All',
                                style: GoogleFonts.aBeeZee(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              String imageUrl =
                                  'http://192.168.1.31:8000/ProductImg/${products[index].productId}/${products[index].variations[0].images[0]}';
                              String formattedPrice = NumberFormat('#,##0')
                                  .format(products[index]
                                      .variations[0]
                                      .skus[0]
                                      .actualPrice);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailpage(
                                          product: products[index]),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
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
                                            products[index].productBrand,
                                            style: GoogleFonts.aBeeZee(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1),
                                          child: Text(
                                            products[index]
                                                .productName
                                                .toUpperCase(),
                                            style: GoogleFonts.aBeeZee(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '₹ $formattedPrice',
                                          style: GoogleFonts.aBeeZee(
                                            color: Colors.green,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: OfferCarousel(),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: AllProducts(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
}

class NewArrivalProduct {
  final String id;
  final String productId;
  final String productName;
  final String productDescription;
  final String productCategory;
  final int productWeight;
  final String productFeatures;
  final DateTime productPublishDatetime;
  final String productPublishStatus;
  final List<String> productTags;
  final String productType;
  final String productGender;
  final String productBrand;
  final List<Variation> variations;

  NewArrivalProduct({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productCategory,
    required this.productWeight,
    required this.productFeatures,
    required this.productPublishDatetime,
    required this.productPublishStatus,
    required this.productTags,
    required this.productType,
    required this.productGender,
    required this.productBrand,
    required this.variations,
  });

  factory NewArrivalProduct.fromJson(Map<String, dynamic> json) {
    // Debug print to see the raw JSON data
    print('New Arrival Product JSON: $json');

    var tagsFromJson = json['product_tags'];
    List<String> tagsList =
        tagsFromJson != null ? List<String>.from(tagsFromJson) : [];

    var variationsFromJson = json['variations'] as List;
    List<Variation> variationsList =
        variationsFromJson.map((i) => Variation.fromJson(i)).toList();

    return NewArrivalProduct(
      id: json['_id']?.toString() ?? '',
      productId: json['product_id']?.toString() ?? '',
      productName: json['product_name']?.toString() ?? '',
      productDescription: json['product_description']?.toString() ?? '',
      productCategory: json['product_category']?.toString() ?? '',
      productWeight: json['product_weight'] ?? 0,
      productFeatures: json['product_features']?.toString() ?? '',
      productPublishDatetime: DateTime.parse(
          json['product_publish_datetime'] ?? '1970-01-01T00:00:00Z'),
      productPublishStatus: json['product_publish_status']?.toString() ?? '',
      productTags: tagsList,
      productType: json['product_type']?.toString() ?? '',
      productGender: json['product_gender']?.toString() ?? '',
      productBrand: json['product_brand']?.toString() ?? '',
      variations: variationsList,
    );
  }
}

class Variation {
  final String color;
  final List<String> images;
  final List<Sku> skus;

  Variation({
    required this.color,
    required this.images,
    required this.skus,
  });

  factory Variation.fromJson(Map<String, dynamic> json) {
    var imagesFromJson = json['images'];
    List<String> imagesList =
        imagesFromJson != null ? List<String>.from(imagesFromJson) : [];

    var skusFromJson = json['skus'] as List;
    List<Sku> skusList = skusFromJson.map((i) => Sku.fromJson(i)).toList();

    return Variation(
      color: json['color']?.toString() ?? '',
      images: imagesList,
      skus: skusList,
    );
  }
}

class Sku {
  final String size;
  final int discount;
  final bool inStock;
  final int quantity;
  final double actualPrice;
  final String id;

  Sku({
    required this.size,
    required this.discount,
    required this.inStock,
    required this.quantity,
    required this.actualPrice,
    required this.id,
  });

  factory Sku.fromJson(Map<String, dynamic> json) {
    return Sku(
      size: json['size']?.toString() ?? '',
      discount: json['discount'] ?? 0,
      inStock: json['in_stock'] ?? false,
      quantity: json['quantity'] ?? 0,
      actualPrice: (json['actualPrice'] is int)
          ? (json['actualPrice'] as int).toDouble()
          : (json['actualPrice'] is double)
              ? json['actualPrice']
              : 0.0,
      id: json['_id']?.toString() ?? '',
    );
  }
}

Future<List<NewArrivalProduct>> fetchNewArrivals() async {
  final response = await http.get(
      Uri.parse('http://192.168.1.31:8000/productAdmin/product/new-arrivals'));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List productsJson = jsonResponse['data'];
    return productsJson
        .map((product) => NewArrivalProduct.fromJson(product))
        .toList();
  } else {
    throw Exception('Failed to load new arrivals');
  }
}
