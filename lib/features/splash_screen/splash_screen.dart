import 'dart:async';

import 'package:dil_hack_e_commerce/features/auth/view/login_page.dart';
import 'package:dil_hack_e_commerce/helpers/animated_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        createRoute(
          const LoginPage(),
        ),
      );
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // used flutter animate packages for image animation
            DilhackLogo()
          ],
        ),
      ),
    );
  }
}

class DilhackLogo extends StatelessWidget {
  const DilhackLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/logo.png').animate().shimmer(
          color: Colors.amber,
          duration: const Duration(seconds: 2),
        );
  }
}
