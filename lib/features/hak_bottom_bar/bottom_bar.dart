import 'package:dil_hack_e_commerce/constants/decodeJwt.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/pages/account/account_page.dart';
import 'package:dil_hack_e_commerce/features/pages/cart/cart_page.dart';
import 'package:dil_hack_e_commerce/features/pages/WishList/wish_list.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/home_page.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class DilHackBottomNavBar extends StatefulWidget {
  const DilHackBottomNavBar({
    super.key,
  });

  @override
  State<DilHackBottomNavBar> createState() => _DilHackBottomNavBarState();
}

class _DilHackBottomNavBarState extends State<DilHackBottomNavBar> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomePage(),
    CartPage(),
    WishlistPage(),
    CreateProfilePage(),
  ];

  // int currentIndex = 0;
  // String userId = '';

  // @override
  // void initState() {
  //   super.initState();
  //   _initializeUser(); // Decode token and get userId
  // }

  // Future<void> _initializeUser() async {
  //   try {
  //     // Decode the token and get userId
  //     Map<String, dynamic> decodedToken = await decodeJwt();
  //     setState(() {
  //       userId = decodedToken[
  //           'userId']; // Assuming 'userId' is the key in your token
  //       // Initialize pages after userId is obtained
  //       pages = [
  //         HomePage(),
  //         CartPage(),
  //         WishlistView(userId: userId),
  //         CreateProfilePage(),
  //       ];
  //     });
  //   } catch (e) {
  //     print("Error decoding token: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while decoding token
          : pages[currentIndex],
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
