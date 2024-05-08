import 'package:dil_hack_e_commerce/core/sized_boxes.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/login_button.dart';
import 'package:dil_hack_e_commerce/features/auth/view_model/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class EnterOtpPage extends StatefulWidget {
  const EnterOtpPage({super.key});

  @override
  State<EnterOtpPage> createState() => _EnterOtpPageState();
}

class _EnterOtpPageState extends State<EnterOtpPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LoginProvider>(context);
    final width = MediaQuery.of(context).size.width;
    String otp = '';
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OTPTextField(
              length: 4,
              width: MediaQuery.of(context).size.width * 0.8,
              fieldWidth: 50,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                otp = pin;
                print("Completed: " + pin);
              },
            ),
            const H50(),
            LoginButton(
              width: width,
              callback: () {
                int generatedOtp = int.parse(otp);
                authProvider.submitOtp(generatedOtp);
              },
              label: 'Submit OTP',
            )
          ],
        ),
      ),
    );
  }
}
