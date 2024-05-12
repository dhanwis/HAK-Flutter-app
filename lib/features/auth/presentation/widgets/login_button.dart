import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback callback;
  final String label;

  const LoginButton(
      {super.key,
      required this.width,
      required this.callback,
      required this.label});
  final double width;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 60,
      width: width * 0.5,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Color.fromARGB(255, 195, 144, 148),
              offset: Offset(-10, 20),
              blurRadius: 10)
        ],
        borderRadius: BorderRadius.circular(20),
        color: Palette.textFormBorder,
      ),
      child: GestureDetector(
        onTap: callback,
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.aBeeZee(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
