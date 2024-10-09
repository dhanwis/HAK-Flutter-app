import 'dart:async';
import 'package:dil_hack_e_commerce/features/auth/presentation/login_page/login_page.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/otp_page/tokenStorage.dart';
import 'package:dil_hack_e_commerce/features/hak_bottom_bar/bottom_bar.dart';

import 'package:dil_hack_e_commerce/helpers/animated_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future _checkTokenAndNavigate() async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // final token = pref.getString('accessToken');

    final token = await TokenStorage().getAccessToken();

    if (token != null && token.isNotEmpty) {
      Timer(
        const Duration(seconds: 3),
        () {
          Navigator.pushReplacement(
            context,
            createRoute(
              const DilHackBottomNavBar(),
            ),
          );
        },
      );
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          createRoute(
            const LoginPage(),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    _checkTokenAndNavigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: DilhackLogo(),
          ),
        ],
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
