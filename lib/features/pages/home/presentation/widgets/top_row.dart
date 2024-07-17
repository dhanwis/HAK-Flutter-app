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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Image.asset(
            'assets/images/logo-2.png',
            color: Colors.black,
            height: screenSize.height * 0.05,
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(width: 5,),
            CircleAvatar(
              radius: screenSize.width * 0.05,
              backgroundColor: Palette.appTheme,
              backgroundImage: AssetImage(
                'assets/images/manji.jpeg',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
