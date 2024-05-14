import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class OtpText extends StatelessWidget {
  const OtpText({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20,left: 40.0,bottom: 20),
      child: Align(alignment: Alignment.centerLeft,
        child: Text(
          'We have send you an OTP on this mobile number',
          style: GoogleFonts.aBeeZee(
              fontSize: width * 0.03,
              color: Colors.pink.shade100,
              fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
