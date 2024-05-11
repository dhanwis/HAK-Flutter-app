import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

class SnackBars{
  static void otpSuccessBar(BuildContext context) {
    IconSnackBar.show(
        snackBarStyle:
            const SnackBarStyle(backgroundColor: Palette.textFormBorder),
        context,
        label: 'Successfully Verified OTP',
        snackBarType: SnackBarType.success);
  }



  static void otpSendBar(BuildContext context, String mobileNumber){
     IconSnackBar.show(
          snackBarStyle:
              const SnackBarStyle(backgroundColor: Palette.textFormBorder),
          context,
          label: 'Sending OTP to $mobileNumber',
          snackBarType: SnackBarType.success);

  }
}
