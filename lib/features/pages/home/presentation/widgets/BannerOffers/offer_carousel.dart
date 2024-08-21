import 'package:dil_hack_e_commerce/features/auth/model/banners.dart' as custom;
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/BannerOffers/productlist_offercarousel.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/product_detailpage.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/productsByCategory.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dil_hack_e_commerce/api/banner_api.dart' as custom;
import 'package:skeletonizer/skeletonizer.dart';

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
    if (_isLoading) {
      return _buildSkeletonLoader();
    }

    if (_banners.isEmpty) {
      return Center();
    }

    return _banners.length == 1 ? _buildSingleBanner() : _buildCarouselSlider();
  }

  Widget _buildSkeletonLoader() {
    return Skeletonizer(
      child: Container(
        height: 230,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildSingleBanner() {
    return GestureDetector(
      onTap: () => _handleBannerClick(_banners[0]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 230,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(_banners[0].imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
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
            return GestureDetector(
              onTap: () => _handleBannerClick(banner),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(banner.imageUrl),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  void _handleBannerClick(custom.Banner banner) {
    switch (banner.offerType) {
      case 'single_product':
        if (banner.targetId is String) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetailPage(productId: banner.targetId),
            ),
          );
        } else {
          print('Single Product Target ID is not a String');
        }
        break;
      case 'category_offer':
        if (banner.targetId is String) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductsByCategory(categoryId: banner.targetId),
            ),
          );
        } else {
          print('Category Offer Target ID is not a String');
        }
        break;
      case 'product_list':
        if (banner.targetId is List<String>) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductByOffercarousel(productIds: banner.targetId),
            ),
          );
        } else {
          print('Product List Target ID is not a List<String>');
        }
        break;
      default:
        print('Unknown offer type: ${banner.offerType}');
        break;
    }
  }
}
