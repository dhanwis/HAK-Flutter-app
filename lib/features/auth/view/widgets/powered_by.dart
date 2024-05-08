

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PoweredByText extends StatelessWidget {
  const PoweredByText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Powered By',
      style: GoogleFonts.aBeeZee(color: Colors.grey.shade500, fontSize: 10),
    );
  }
}
