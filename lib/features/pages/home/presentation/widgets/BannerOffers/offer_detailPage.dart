import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/BannerOffers/categoryProductScreen.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/BannerOffers/productlistScreen.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/BannerOffers/singleProductScreen.dart';
import 'package:flutter/material.dart';

class OfferDetailsScreen extends StatelessWidget {
  final Banner banner;

  OfferDetailsScreen({required this.banner});

  @override
  Widget build(BuildContext context) {
    switch (banner) {
      case 'singleProduct':
        return SingleProductScreen(productId: banner.targetId);
      case 'category':
        return CategoryProductsScreen(categoryId: banner.targetId);
      case 'productList':
        return ProductListScreen(listId: banner.targetId);
      default:
        return Scaffold(
          appBar: AppBar(title: Text('Offer Details')),
          body: Center(child: Text('Unknown offer type')),
        );
    }
  }
}
