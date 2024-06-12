import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/bloc/home_bloc.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/categories.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/offer_carousel.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/search.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/top_row.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
  //  final bloc = BlocProvider.of<HomeBloc>(context);
    List<IconData> icons = [
      EvaIcons.google,
      EvaIcons.clock,
      EvaIcons.facebook,
      EvaIcons.inbox,
      EvaIcons.headphones,
      EvaIcons.bluetooth,
      EvaIcons.wifi
    ];

    final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            backgroundColor: Colors.white,
            title: TopRow(),
          ),
//           SliverAppBar(
//             floating: true,
//
//             backgroundColor: Colors.white,
//             expandedHeight: 200,
// title: AppSearchBar(width: width,),
//             flexibleSpace: FlexibleSpaceBar(background: OfferCarousel(),)
//           ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Categories(
                icons: icons,
              ),
            ),
          ),
          SliverAppBar(
              pinned: true,
              backgroundColor: Colors.white,
              expandedHeight: 380,
              title: AppSearchBar(
                width: width,
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                    padding: const EdgeInsets.only(
                      top: 100,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'New Arrivals',
                                style: GoogleFonts.aBeeZee(
                                    fontWeight: FontWeight.w800, fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                  'View All',
                                  style: GoogleFonts.aBeeZee(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  List products = [
                                    'assets/products/pr5.jpeg',
                                    'assets/products/pr6.jpeg',
                                    'assets/products/pr2.jpeg',
                                    'assets/products/pr4.jpeg',
                                    'assets/products/pr3.jpeg',
                                    'assets/products/pr1.jpeg'
                                  ];
                                  List productsNames = [
                                    'Saree',
                                    'Shirt',
                                    'Top',
                                    'TShirts',
                                    'Lahanka',
                                    'Churidar'
                                  ];
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: Image.asset(
                                              products[index],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Text(
                                            'BrandName',
                                            style: GoogleFonts.aBeeZee(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1),
                                          child: Text(
                                            productsNames[index]
                                                .toString()
                                                .toUpperCase(),
                                            style: GoogleFonts.aBeeZee(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          '₹ 999',
                                          style: GoogleFonts.aBeeZee(
                                              color: Colors.green,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    )),
              )),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: OfferCarousel(),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
}
