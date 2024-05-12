import 'package:dil_hack_e_commerce/core/const/validator.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:flutter/material.dart';

class OtpTextField extends StatefulWidget {
  final TextEditingController controller;
  final double width;

  const OtpTextField({super.key, required this.width,required this.controller});

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
        controller: widget.controller,
        decoration: InputDecoration(
          
          prefixIcon: const Icon(
            Icons.phone,
            color: Colors.grey,
          ),
          hintText: 'Mobile Number',
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
        color: Palette.textFormBorder,
      ),
    );
  }
}
