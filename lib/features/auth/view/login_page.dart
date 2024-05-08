import 'dart:developer';

import 'package:dil_hack_e_commerce/core/sized_boxes.dart';
import 'package:dil_hack_e_commerce/core/theme/loading_dilhak.dart';

import 'package:dil_hack_e_commerce/features/auth/view/widgets/login_image.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/dil_hack_grey_logo.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/login_button.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/login_field.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/powered_by.dart';
import 'package:dil_hack_e_commerce/features/auth/view_model/provider/login_proviedr.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final auth = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  LoginImage(height: height, width: width).animate().fade(),
                  const H50(),
                  OtpTextField(
                    width: width,
                    controller: mobileNumberController,
                  ),
                  const H30(),
                  LoginButton(
                    label: 'Send OTP',
                    width: width,
                    callback: () {
                      if (_formKey.currentState!.validate()) {
                        auth.loginCustomer(
                            mobileNumberController.text, context);
                      }
                    },
                  ),
                  const H50(),
                  const PoweredByText(),
                  const DhanwisTechLogo()
                ],
              ),
            ),
            LoadingAnimation(
              height: height,
              isLoading: auth.isLoading,
            )
          ],
        ),
      ),
    );
  }
}
