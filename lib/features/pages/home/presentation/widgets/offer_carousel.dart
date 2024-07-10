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
      print('Error fetching banners in UI: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_banners.isEmpty) {
      return Center(child: Text('No banners available'));
    }

    return _banners.length == 1 ? _buildSingleBanner() : _buildCarouselSlider();
  }

  Widget _buildSingleBanner() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 230,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(_banners[0].imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }

  Widget _buildCarouselSlider() {
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
        onPageChanged: (index, reason) {},
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
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(1),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
