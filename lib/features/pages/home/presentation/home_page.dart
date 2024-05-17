import 'package:dil_hack_e_commerce/core/sized_boxes.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List icons = [
      EvaIcons.google,
      EvaIcons.clock,
      EvaIcons.facebook,
      EvaIcons.inbox,
      EvaIcons.headphones,
      EvaIcons.bluetooth,
      EvaIcons.wifi
    ];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.only(top: 30),
        children: [
          const TopRow(),
          const H30(),
          SearchBar(width: width),
          const H30(),
          Categories(icons: icons),
          GridItems(height: height)
        ],
      ),
    );
  }
}











// gridItems

class GridItems extends StatelessWidget {
  const GridItems({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // color: Color.fromARGB(100, 246, 191, 204),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      height: height * 0.74,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 300, crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.pink.shade100,
                        Colors.pink.shade50,
                        Colors.pink.shade50
                      ]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Image.asset(index % 3 == 0
                            ? 'assets/images/sareee.png'
                            : 'assets/images/anarkali.png'),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}







// Category items
class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.icons,
  });

  final List icons;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(141, 250, 170, 177),
                    borderRadius: BorderRadius.circular(15)),
                width: 70,
                child: Center(
                  child: Icon(
                    icons[index],
                    color: const Color.fromARGB(159, 169, 72, 80),
                  ),
                ),
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
                  color: const Color.fromARGB(100, 246, 191, 204)),
              child: TextFormField(
                style: const TextStyle(color: Palette.shadowPink),
                cursorColor: Colors.grey.shade50,
                decoration: InputDecoration(
                    hintText: 'Search Products',
                    hintStyle: GoogleFonts.aBeeZee(color: Palette.appTheme),
                    prefixIcon: const Icon(
                      EvaIcons.search,
                      color: Palette.appTheme,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    border: InputBorder.none),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 10),
          child: Container(
            decoration: BoxDecoration(
                color: Palette.appTheme,
                borderRadius: BorderRadius.circular(15)),
            height: 60,
            width: 60,
            child: const Center(
              child: Icon(
                EvaIcons.arrowForward,
                color: Color.fromARGB(255, 169, 72, 80),
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
              style: GoogleFonts.aBeeZee(color: Palette.appTheme),
            ),
            Text(
              'Manjima',
              style: GoogleFonts.aBeeZee(
                  color: const Color.fromARGB(255, 209, 86, 96)),
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
