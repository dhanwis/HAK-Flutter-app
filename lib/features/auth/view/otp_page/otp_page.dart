import 'package:dil_hack_e_commerce/core/sized_boxes.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/login_button.dart';
import 'package:dil_hack_e_commerce/features/auth/view_model/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class EnterOtpPage extends StatefulWidget {
  final String mobileNumber;
  const EnterOtpPage({super.key, required this.mobileNumber});

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
            Text(
              'OTP Verification',
              style: GoogleFonts.aBeeZee(
                  fontWeight: FontWeight.bold, fontSize: width * 0.07),
            ),
            H50(),
            Text(
              'Enter The Code from the sms we sent to',
              style: GoogleFonts.aBeeZee(
                fontWeight: FontWeight.bold,
              ),
            ),
            H30(),
            Text(
              widget.mobileNumber,
              style: GoogleFonts.aBeeZee(
                fontSize: width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            H50(),
            Pinput(
              onCompleted: (pin) {
                otp = pin;
              },
              onSubmitted: (value) {
                otp = value;
              },
            ),
            const H50(),
            LoginButton(
              width: width,
              callback: () {
                authProvider.submitOtp(otp, context);
              },
              label: 'Submit OTP',
            ),
            const H30(),
            TextButton(onPressed: () {}, child: const Text('Resend OTP'))
          ],
        ),
      ),
    );
  }
}
