import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopRow extends StatelessWidget {
  const TopRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/images/logo.png',
              color: Colors.black,
              height: screenSize.height * 0.05,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome 👋',
                style: GoogleFonts.aBeeZee(fontSize: screenSize.width * 0.04),
              ),
              Text(
                'Manjima',
                style: GoogleFonts.aBeeZee(fontSize: screenSize.width * 0.04),
              ),
            ],
          ),
          CircleAvatar(
            radius: screenSize.width * 0.05,
            backgroundColor: Palette.appTheme,
            backgroundImage: AssetImage(
              'assets/images/manji.jpeg',
            ),
          ),
        ],
      ),
    );
  }
}
