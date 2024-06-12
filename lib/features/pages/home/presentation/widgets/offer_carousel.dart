



import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
        onPageChanged: (index, d) {

        },
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
