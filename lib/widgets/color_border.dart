import 'package:flutter/material.dart';

class ColorBorder extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final EdgeInsets? innerPadding;
  final Widget? child;
  final Color? borderColor;
  final double? borderRadius;
  const ColorBorder(
      {super.key,
      this.child,
      this.borderRadius,
      this.borderColor,
      this.innerPadding,
      this.padding,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding?? EdgeInsets.zero,
      child: Container(
        height: height,
        width: width,
        padding: innerPadding ?? EdgeInsets.zero,
        decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 0)),
        child: child,
      ),
    );
  }
}
