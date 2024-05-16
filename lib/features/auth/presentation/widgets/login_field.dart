import 'package:dil_hack_e_commerce/core/const/validator.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpTextField extends StatefulWidget {
  final TextEditingController controller;
  final double width;

  const OtpTextField(
      {super.key, required this.width, required this.controller});

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.width * 0.7),
      child: TextFormField(
        validator: Validators.phoneValidator,
        keyboardType: TextInputType.phone,
        controller: widget.controller,
        style: GoogleFonts.aBeeZee(),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.phone,
            color: Color.fromARGB(255, 132, 124, 124),
          ),
          hintText: 'Mobile Number',
          errorBorder: _border(),
          enabledBorder: _border(),
          focusedBorder: _border(),
          border: _border(),
        ),
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: const BorderSide(
        width: 3.0,
        color: Palette.appTheme,
      ),
    );
  }
}
