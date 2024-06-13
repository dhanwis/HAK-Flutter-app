import 'package:dil_hack_e_commerce/core/theme/palette.dart';

import 'package:dil_hack_e_commerce/features/pages/account/account_page.dart';
//import 'package:dil_hack_e_commerce/features/pages/account/account_page.dart';
import 'package:dil_hack_e_commerce/features/pages/cart/cart_page.dart';
import 'package:dil_hack_e_commerce/features/pages/fav/fav_page.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/home_page.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = const [
    HomePage(),
    CartPage(),
    FavPage(),
    AccountPage(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: SnakeNavigationBar.color(
        height: 50,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
        backgroundColor: Palette.appTheme,
        selectedItemColor: Colors.black,
        snakeViewColor: Colors.pink.shade50,
        snakeShape: SnakeShape.rectangle,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.homeOutline), label: 'Home'),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.shopping_cart),
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.starOutline), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: 'Profile'),
        ],
      ),
    );
  }
}
