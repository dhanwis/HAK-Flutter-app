import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dil_hack_e_commerce/features/pages/account/account_page.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFFAAAB1),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: Lottie.asset(
              'assets/images/wishlistlottie.json',
              height: 180,
              width: 180,
            ),
          ),
          Center(
            child: Text("Your Wishlist Is Empty !",
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    color: Colors.grey.shade500,
                    fontSize: 15)),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 120, right: 120),
            child: ElevatedButton(
              child: const Text(
                'Shop Now',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountPage(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFAAAB1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
