


import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyText extends StatelessWidget {
  const VerifyText({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, top:30),
      child: Align(alignment: Alignment.centerLeft,
        child: Text(
          'Verify Your Mobile Number',
          style: GoogleFonts.aBeeZee(
              fontSize: width * 0.05,
              color: Palette.textFormBorder,
              fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
