import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Palette.shadowPink,
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(400),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(400),
        ),
        child: Image.asset(
          'assets/images/shopping.jpeg',
          height: height * 0.55,
          width: width,
          fit: BoxFit.cover,
        ).animate().fade(),
      ),
    );
  }
}
