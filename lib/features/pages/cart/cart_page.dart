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
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        //   leading: IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => HomeScreen()),
        //       );
        //     },
        //     icon: const Icon(Icons.arrow_back),
        //   ),
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFFAAAB1),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Carttile(
            height: 120,
            width: 150,
            imagepath: "assets/products/pr6.jpeg",
            itemname: "saree",
            itemprize: 300,
          ),
          Carttile(
            height: 120,
            width: 150,
            imagepath: "assets/products/pr7.jpeg",
            itemname: "kurta",
            itemprize: 200,
          ),
          SizedBox(
            height: 380,
          ),
          // ElevatedButton(
          //   child: Text(
          //     'Continue',
          //     style: TextStyle(color: Colors.black),
          //   ),
          //   onPressed: () {},
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.pinkAccent,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class Carttile extends StatefulWidget {
  final double height;
  final double width;
  final String imagepath;
  final String itemname;
  final int itemprize;
  final IconData itemicon;

  Carttile({
    super.key,
    required this.height,
    required this.width,
    required this.imagepath,
    required this.itemname,
    required this.itemprize,
    this.itemicon = Icons.arrow_forward,
  });

  @override
  State<Carttile> createState() => _CarttileState();
}

class _CarttileState extends State<Carttile> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: widget.height,
              width: widget.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(widget.imagepath, height: 120),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.itemname,
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.itemprize.toString(),
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        "Size:L",
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        "Remove",
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (count > 0) {
                              count--;
                              setState(() {});
                            }
                          },
                          icon: Icon(Icons.remove_circle)),
                      Text(
                        count.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      IconButton(
                          onPressed: () {
                            count++;
                            setState(() {});
                          },
                          icon: Icon(Icons.add_circle)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
