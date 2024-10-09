import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryButton extends StatelessWidget {
  final bool? useIcon;
  final bool? loading;
  final EdgeInsets? insidePadding;
  final Color? labelColor;
  final double? borderRadius;
  final double? height;
  final String? label;
  final double? width;
  final Color? backGroundColor;
  final VoidCallback? callBack;
  final TextStyle? labelStyle;
  const PrimaryButton({
    super.key,
    this.labelStyle,
    this.callBack,
    this.borderRadius,
    this.label,
    this.height,
    this.width,
    this.loading = false,
    this.insidePadding,
    this.backGroundColor,
    this.labelColor, this.useIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: callBack,
        style: ElevatedButton.styleFrom(
          foregroundColor: labelColor,
          backgroundColor: backGroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
          ),
        ),
        child: Padding(
          padding: insidePadding ?? const EdgeInsets.all(8.0),
          child: (loading == true)
              ? const SpinKitSpinningLines(
                  color: Colors.white,
                  size: 20,
                )
              : Text(
                  label ?? "",
                  style: labelStyle,
                ),
        ),
      ),
    );
  }
}
