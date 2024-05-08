import 'dart:ui';
import 'package:shimmer/shimmer.dart';

import 'package:dil_hack_e_commerce/core/sized_boxes.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/auth/login_button.dart';
import 'package:dil_hack_e_commerce/features/auth/widgets/dil_hack_grey_logo.dart';
import 'package:dil_hack_e_commerce/features/auth/widgets/login_button.dart';
import 'package:dil_hack_e_commerce/features/auth/widgets/login_field.dart';
import 'package:dil_hack_e_commerce/features/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                LoginImage(height: height, width: width),
                const H50(),
                OtpTextField(width: width),
                const H30(),
                LoginButton(width: width),
                const H50(),
                const DilhackLogoGrey()
              ],
            ),
            LoadingAnimation(height: height)
          ],
        ),
      ),
    );
  }
}

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: height,
          color: Color.fromARGB(9, 128, 63, 63),
          child: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.black,
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 250,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
