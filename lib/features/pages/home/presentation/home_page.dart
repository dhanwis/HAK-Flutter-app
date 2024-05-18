import 'package:carousel_slider/carousel_slider.dart';
import 'package:dil_hack_e_commerce/core/sized_boxes.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/bloc/home_bloc.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
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
      body: ListView(
        padding: const EdgeInsets.only(top: 30),
        children: [
          const TopRow(),
          const H20(),
          SearchBar(width: width),
          const H20(),
          Categories(icons: icons),
          const OfferCarousel()
        ],
      ),
    );
  }
}

class OfferCarousel extends StatelessWidget {
  const OfferCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 230,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        onPageChanged: (index, d) {},
        scrollDirection: Axis.horizontal,
      ),
      items: [
        'assets/images/banner1.jpeg',
        'assets/images/banner3.jpg',
        'assets/images/banner2.jpeg',
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(i)),
                  borderRadius: BorderRadius.circular(1)),
            );
          },
        );
      }).toList(),
    );
  }
}

// gridItems

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.icons,
  });

  final List icons;

  @override
  Widget build(BuildContext context) {
    List<String> labels = [
      'Saree',
      'TShirts',
      'Kurti',
      'Lehanka',
      'Salwar',
      'Western',
      'Traditional'
    ];
    return SizedBox(
      height: 100,
      child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10, bottom: 0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(1, 1),
                              blurRadius: 10)
                        ],
                        border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(99, 202, 201, 202),
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    width: 60,
                    height: 60,
                    child: Center(
                      child: Icon(
                        icons[index],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    labels[index],
                    style: GoogleFonts.aBeeZee(letterSpacing: 1),
                  )
                ],
              ),
            );
          }),
    );
  }
}

// search bar
class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: width * 0.06),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(99, 202, 201, 202),
              ),
              child: TextFormField(
                style: const TextStyle(color: Palette.shadowPink),
                cursorColor: Colors.grey.shade50,
                decoration: InputDecoration(
                    hintText: 'Search Products',
                    hintStyle: GoogleFonts.aBeeZee(
                        color: const Color.fromARGB(255, 182, 182, 182)),
                    prefixIcon: const Icon(
                      EvaIcons.search,
                      color: Color.fromARGB(255, 175, 174, 174),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    border: InputBorder.none),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<HomeBloc>(context).add(FetchCategoriesEvent());
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 235, 228, 228),
                  borderRadius: BorderRadius.circular(15)),
              height: 60,
              width: 60,
              child: const Center(
                child: Icon(
                  EvaIcons.arrowForward,
                  color: Color.fromARGB(255, 147, 144, 144),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

// top row
class TopRow extends StatelessWidget {
  const TopRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/images/logo.png',
            color: Colors.black,
            height: 40,
          ),
        ),
        const SizedBox(
          width: 70,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Welcome 👋',
              style: GoogleFonts.aBeeZee(),
            ),
            Text(
              'Manjima',
              style: GoogleFonts.aBeeZee(),
            )
          ],
        ),
        const CircleAvatar(
          radius: 20,
          backgroundColor: Palette.appTheme,
          backgroundImage: AssetImage(
            'assets/images/manji.jpeg',
          ),
        ),
      ],
    );
  }
}
