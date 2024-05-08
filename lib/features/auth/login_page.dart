import 'package:dil_hack_e_commerce/core/sized_boxes.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/auth/login_button.dart';
import 'package:dil_hack_e_commerce/features/auth/widgets/dil_hack_grey_logo.dart';
import 'package:dil_hack_e_commerce/features/auth/widgets/login_button.dart';
import 'package:dil_hack_e_commerce/features/auth/widgets/login_field.dart';
import 'package:flutter/material.dart';
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
        child: Column(
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
      ),
    );
  }
}
