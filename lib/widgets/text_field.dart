import 'package:flutter/material.dart';

import '../const/colors_class.dart';

class PrimaryTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String?Function(String?)? validator;
  final bool? filled;
  final bool? underLineBorder;
  final double? borderWidth;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final Widget? surffix;
  final Color? borderColor;
  final String? label;
  final TextStyle? labelStyle;
  final bool? obscure;
  final Color? cursorColor;
  final EdgeInsets? contentPadding;
  final Color? underLineColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? hintColor;

  const PrimaryTextField({


    super.key,

    this.validator,
    this.borderRadius,
    this.contentPadding,
    this.surffix,
    this.controller,
    this.obscure = false,
    this.cursorColor,
    this.labelStyle,
    this.label,
    this.fillColor,
    this.padding,
    this.borderWidth,
    this.borderColor,
    this.filled = false,
    this.underLineBorder =false,
    this.underLineColor, this.hintText, this.hintStyle, this.hintColor
  });

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0),
      child: TextFormField(

        validator: widget.validator,

        controller: widget.controller,
        cursorColor: widget.cursorColor ?? ColorsClass.black,
        obscureText: widget.obscure ?? false,
        decoration: InputDecoration(
          hintStyle: widget.hintStyle?? TextStyle(color: widget.hintColor?? ColorsClass.black),
          suffixIcon: widget.surffix,
          contentPadding: widget.contentPadding?? EdgeInsets.zero,
          label: Text(widget.label ?? ''),
          labelStyle: widget.labelStyle?? TextStyle(color: ColorsClass.black),
          filled: widget.filled,
          fillColor: widget.fillColor,
          enabledBorder: widget.underLineBorder==true?
              UnderlineInputBorder(
                borderSide: BorderSide(color:widget.underLineColor?? ColorsClass.black )
              ):

          OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(1),
            borderSide: BorderSide(
              width: widget.borderWidth?? 1,
              color: widget.borderColor ?? Colors.transparent,
            ),
          ) ,
          focusedBorder:widget.underLineBorder==true?
          UnderlineInputBorder(
              borderSide: BorderSide(color:widget.underLineColor?? ColorsClass.black )
          ): OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(1),
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.transparent,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(1),
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
