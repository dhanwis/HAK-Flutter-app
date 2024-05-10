import 'package:dil_hack_e_commerce/core/sized_boxes.dart';
import 'package:dil_hack_e_commerce/core/theme/loading_dilhak.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/login_image.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/dil_hack_grey_logo.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/login_button.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/login_field.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/powered_by.dart';
import 'package:dil_hack_e_commerce/features/auth/view_model/provider/login_provider.dart';
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top:30),
                    child: Align(alignment: Alignment.centerLeft,
                      child: Text(
                        'Verify Your Mobile Number',
                        style: GoogleFonts.aBeeZee(
                            fontSize: width * 0.05,
                            color: Palette.textFormBorder,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(top:20,left: 10.0,bottom: 20),
                    child: Align(alignment: Alignment.centerLeft,
                      child: Text(
                        'We have send you an OTP on this mobile number',
                        style: GoogleFonts.aBeeZee(
                            fontSize: width * 0.03,
                            color: Colors.pink.shade100,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
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
                  H30(),
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
