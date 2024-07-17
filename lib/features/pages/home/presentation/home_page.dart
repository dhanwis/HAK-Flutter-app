import 'package:dil_hack_e_commerce/api/new_arrivals_api.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/product_detailpage.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/all_products.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/categories.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/offer_carousel.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/search.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/top_row.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = GetAllNewArrivalsApi().fetchNewArrivals();
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
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: TopRow(),
            centerTitle: false,
            floating: true,
            backgroundColor: Colors.transparent,
          ),
          SliverToBoxAdapter(
            child: AppSearchBar(
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
          FutureBuilder<List<Product>>(
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
                List<Product> products = snapshot.data!;
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
                          height: 330,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              String imageUrl =
                                  products[index].variations[0].images[0];

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
                                      builder: (context) => ProductDetailPage(
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
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
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
