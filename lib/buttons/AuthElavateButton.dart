import 'package:dil_hack_e_commerce/constants/userId.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/login_page/login_page.dart';
import 'package:dil_hack_e_commerce/features/pages/cart/cart_page.dart';
import 'package:flutter/material.dart';

class AuthElevatedButtonForCart extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final VoidCallback? onPressed; // Optional callback for custom actions

  const AuthElevatedButtonForCart({
    Key? key,
    required this.label,
    this.width = 200,
    this.height = 50,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed ??
            () {
              if (UserIdProvider.userId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            },
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
