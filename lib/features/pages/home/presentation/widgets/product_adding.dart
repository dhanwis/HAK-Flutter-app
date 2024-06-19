import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductsModel product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '₹${product.price}',
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductsModel {
  final String name;
  final double price;
  final String imageUrl;

  ProductsModel({
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}
