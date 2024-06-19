import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopRow extends StatelessWidget {
  const TopRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/images/logo.png',
              color: Colors.black,
              height: 40,
            ),
          ),
          const SizedBox(
            width: 35,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome 👋',
                style: GoogleFonts.aBeeZee(fontSize: 15),
              ),
              Text(
                'Manjima',
                style: GoogleFonts.aBeeZee(fontSize: 15),
              ),
            ],
          ),
          const CircleAvatar(
            radius: 20,
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
