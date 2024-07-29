// import 'dart:ui';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dil_hack_e_commerce/features/pages/account/account_page.dart';
// import 'package:dil_hack_e_commerce/features/pages/home/presentation/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:lottie/lottie.dart';

// class CartPage extends StatefulWidget {
//   const CartPage({super.key});

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.arrow_back),
//         ),
//         centerTitle: true,
//         title: Text(
//           "Cart",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Color(0xFFFAAAB1),
//       ),
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 180),
//             child: Lottie.asset(
//               'assets/images/Animation - 1717999632927 (1).json',
//               height: 200,
//               width: 200,
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Center(
//             child: Text("Your Cart Is Empty !",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w200,
//                     color: Colors.grey.shade500,
//                     fontSize: 15)),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 100, right: 100),
//             child: ElevatedButton(
//               child: const Text(
//                 'Shop Now',
//                 style: TextStyle(color: Colors.black),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AccountPage(),
//                     ));
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFFAAAB1),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Product> products = [
    Product(
      imageUrl: 'assets/products/pr4.jpeg',
      productName: 'Gown',
      productDescription:
          'Silhouette: A-line, fit-and-flare, sheath, empire waist, ',
      size: 'XXL',
      quantity: 1,
      price: 575,
      oldPrice: 2499,
      discount: 77,
      savings: 1924,
    ),
    Product(
      imageUrl: 'assets/products/pr4.jpeg',
      productName: 'Georget Saree',
      productDescription: 'Traditional Indian garment for women.',
      size: 'XL',
      quantity: 1,
      price: 597.00,
      oldPrice: 2998.00,
      discount: 80,
      savings: 2401.00,
    ),
    Product(
      imageUrl: 'assets/products/pr4.jpeg',
      productName: 'Kanji Silk Saree',
      productDescription: 'Traditional Indian garment for women.',
      size: 'XL',
      quantity: 1,
      price: 741.00,
      oldPrice: 1899.00,
      discount: 61,
      savings: 1158.00,
    ),
  ];

  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    totalPrice = _calculateTotalPrice();
  }

  void _removeProduct(int index) {
    setState(() {
      products.removeAt(index);
      totalPrice = _calculateTotalPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_ios),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: products[index],
                  onRemove: () => _removeProduct(index),
                );
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'View price details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        elevation: 5,
                        shadowColor: Colors.black,
                      ),
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateTotalPrice() {
    return products.fold(0, (total, product) => total + product.price);
  }
}

class Product {
  final String imageUrl;
  final String productName;
  final String productDescription;
  final String size;
  final int quantity;
  final double price;
  final double oldPrice;
  final int discount;
  final double savings;

  Product({
    required this.imageUrl,
    required this.productName,
    required this.productDescription,
    required this.size,
    required this.quantity,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.savings,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;

  const ProductCard({
    required this.product,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              product.imageUrl,
              width: 150,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(product.productDescription),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        'Size ${product.size}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Qty ${product.quantity}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text('₹${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8.0),
                      Text(
                        '₹${product.oldPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text('(${product.discount}%)'),
                    ],
                  ),
                  Text(
                    'You save ₹${product.savings.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text('10 day Return and Exchange'),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: onRemove,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: Text(
                          'Remove',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
