
import 'package:dil_hack_e_commerce/core/sized_boxes.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/login_button.dart';
import 'package:dil_hack_e_commerce/features/auth/view_model/provider/login_provider.dart';
import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class EnterOtpPage extends StatefulWidget {
  const EnterOtpPage({super.key});

  @override
  State<EnterOtpPage> createState() => _EnterOtpPageState();
}

class _EnterOtpPageState extends State<EnterOtpPage> {
      String otp = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LoginProvider>(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Pinput(
              onCompleted: (pin) {
                otp = pin;
                
              },
              onSubmitted: (value){
                otp = value;
              },
            ),
            const H50(),
            LoginButton(
              width: width,
              callback: () {

                 authProvider.submitOtp(otp,context);
              },
              label: 'Submit OTP',
            )
          ],
        ),
      ),
    );
  }
}
