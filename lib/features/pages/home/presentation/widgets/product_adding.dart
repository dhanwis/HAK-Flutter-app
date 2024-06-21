// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class ProductGrid extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 0.47,
//       ),
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         final product = products[index];
//         return Card(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 onTap: () {},
//                 child: Image.asset(
//                   product.imageUrl,
//                   fit: BoxFit.cover,
//                   height: 300,
//                   width: double.infinity,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(product.name,
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     Text('₹${product.price}',
//                         style: TextStyle(color: Colors.green)),
//                     Text(product.specialOffers,
//                         style: TextStyle(color: Colors.red)),
//                     Text('Free Delivery'),
//                   ],
//                 ),
//               ),
//               Spacer(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.favorite_border),
//                     onPressed: () {},
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.shopping_cart),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class Product {
//   final String imageUrl;
//   final String name;
//   final double price;
//   final String specialOffers;

//   Product({
//     required this.imageUrl,
//     required this.name,
//     required this.price,
//     required this.specialOffers,
//   });
// }

// final List<Product> products = [
//   Product(
//     imageUrl: 'assets/products/pr7.jpeg',
//     name: 'Ad Trendy Superior Saree',
//     price: 424,
//     specialOffers: '2 Special Offers',
//   ),
//   Product(
//     imageUrl: 'assets/products/pr8.jpeg',
//     name: 'Aagyeyi Attractive Saree',
//     price: 309,
//     specialOffers: '1 Special Offer',
//   ),
//   Product(
//     imageUrl: 'assets/products/pr9.jpeg',
//     name: 'Aagyeyi Attractive Saree',
//     price: 309,
//     specialOffers: '1 Special Offer',
//   ),
//   Product(
//     imageUrl: 'assets/products/pr10.jpeg',
//     name: 'Aagyeyi Attractive Saree',
//     price: 309,
//     specialOffers: '1 Special Offer',
//   ),
//   Product(
//     imageUrl: 'assets/products/pr1.jpeg',
//     name: 'Aagyeyi Attractive Saree',
//     price: 309,
//     specialOffers: '1 Special Offer',
//   ),
//   Product(
//     imageUrl: 'assets/products/pr7.jpeg',
//     name: 'Aagyeyi Attractive Saree',
//     price: 309,
//     specialOffers: '1 Special Offer',
//   ),
// ];
// // sliverbox adapter

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.47,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final product = products[index];
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        height: 300,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('₹${product.price}',
                              style: TextStyle(color: Colors.green)),
                          Text(product.specialOffers,
                              style: TextStyle(color: Colors.red)),
                          Text('Free Delivery'),
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.shopping_cart),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            childCount: products.length,
          ),
        ),
      ],
    );
  }
}

class Product {
  final String imageUrl;
  final String name;
  final double price;
  final String specialOffers;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.specialOffers,
  });
}

final List<Product> products = [
  Product(
    imageUrl: 'assets/products/pr7.jpeg',
    name: 'Ad Trendy Superior Saree',
    price: 424,
    specialOffers: '2 Special Offers',
  ),
  Product(
    imageUrl: 'assets/products/pr8.jpeg',
    name: 'Aagyeyi Attractive Saree',
    price: 309,
    specialOffers: '1 Special Offer',
  ),
  Product(
    imageUrl: 'assets/products/pr9.jpeg',
    name: 'Aagyeyi Attractive Saree',
    price: 309,
    specialOffers: '1 Special Offer',
  ),
  Product(
    imageUrl: 'assets/products/pr10.jpeg',
    name: 'Aagyeyi Attractive Saree',
    price: 309,
    specialOffers: '1 Special Offer',
  ),
  Product(
    imageUrl: 'assets/products/pr1.jpeg',
    name: 'Aagyeyi Attractive Saree',
    price: 309,
    specialOffers: '1 Special Offer',
  ),
  Product(
    imageUrl: 'assets/products/pr7.jpeg',
    name: 'Aagyeyi Attractive Saree',
    price: 309,
    specialOffers: '1 Special Offer',
  ),
];
