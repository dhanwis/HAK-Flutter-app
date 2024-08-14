// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:dil_hack_e_commerce/api/banner_api.dart' as custom;

// class OfferCarousel extends StatefulWidget {
//   const OfferCarousel({Key? key}) : super(key: key);

//   @override
//   _OfferCarouselState createState() => _OfferCarouselState();
// }

// class _OfferCarouselState extends State<OfferCarousel> {
//   final custom.BannerService _bannerService = custom.BannerService();
//   List<custom.Banner> _banners = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchBanners();
//   }

//   Future<void> _fetchBanners() async {
//     try {
//       final banners = await _bannerService.fetchBanners();
//       setState(() {
//         _banners = banners;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {}

//     if (_banners.isEmpty) {
//       // return Center(child: Text());
//     }

//     return _banners.length == 1
//         ? _buildCarouselSlider()
//         : _buildCarouselSlider();
//   }

//   Widget _buildSingleBanner() {
//     return Container(
//       height: 20,
//       width: 800,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: NetworkImage(_banners[0].imageUrl),
//           fit: BoxFit.contain,
//         ),
//         borderRadius: BorderRadius.circular(1),
//       ),
//     );
//   }

//   Widget _buildCarouselSlider() {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 350,
//         enableInfiniteScroll: true,
//         reverse: false,
//         autoPlay: true,
//         autoPlayInterval: const Duration(seconds: 3),
//         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//         autoPlayCurve: Curves.fastOutSlowIn,
//         enlargeCenterPage: true,
//         onPageChanged: (index, reason) {},
//         scrollDirection: Axis.horizontal,
//       ),
//       items: _banners.map((banner) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Container(
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(banner.imageUrl),
//                   fit: BoxFit.contain,
//                 ),
//                 borderRadius: BorderRadius.circular(1),
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }
// }

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dil_hack_e_commerce/api/banner_api.dart' as custom;

class OfferCarousel extends StatefulWidget {
  const OfferCarousel({Key? key}) : super(key: key);

  @override
  _OfferCarouselState createState() => _OfferCarouselState();
}

class _OfferCarouselState extends State<OfferCarousel> {
  final custom.BannerService _bannerService = custom.BannerService();
  List<custom.Banner> _banners = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBanners();
  }

  Future<void> _fetchBanners() async {
    try {
      final banners = await _bannerService.fetchBanners();
      setState(() {
        _banners = banners;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child:
          _banners.length == 1 ? _buildSingleBanner() : _buildCarouselSlider(),
    );
  }

  Widget _buildSingleBanner() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_banners[0].imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 500,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: _banners.map((banner) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(banner.imageUrl),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
