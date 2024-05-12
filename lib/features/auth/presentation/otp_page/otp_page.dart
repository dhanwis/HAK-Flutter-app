import 'package:dil_hack_e_commerce/core/sized_boxes.dart';
import 'package:dil_hack_e_commerce/core/theme/loading_dilhak.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/auth_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/login_page/login_page.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/login_button.dart';
import 'package:dil_hack_e_commerce/features/home_screen/home_screen.dart';
import 'package:dil_hack_e_commerce/helpers/animated_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pinput/pinput.dart';

class EnterOtpPage extends StatefulWidget {
  final String mobileNumber;
  const EnterOtpPage({super.key, required this.mobileNumber});

  @override
  State<EnterOtpPage> createState() => _EnterOtpPageState();
}

class _EnterOtpPageState extends State<EnterOtpPage> {
  String otp = '';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    bool loading = false;
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is OtpValidatedState) {
        Navigator.pushAndRemoveUntil(context,
            createRoute(HomeScreen(token: state.token)), (route) => false);
      }
      if (state is OtpValidatingErrorState) {
        Navigator.push(
          context,
          createRoute(
            const LoginPage(),
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            IconSnackBar.show(
                snackBarStyle: const SnackBarStyle(
                    backgroundColor: Palette.textFormBorder),
                context,
                label: 'Try Again After Some Time',
                snackBarType: SnackBarType.fail),
          );
      }
      if (state is WrongMobileNumberState) {
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      if (state is OtpValidationWaitingState) {
        loading = true;
      } else {
        loading = false;
      }

      return Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'OTP Verification',
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold, fontSize: width * 0.07),
                  ),
                  const H50(),
                  Text(
                    'Enter The Code from the sms we sent to',
                    style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const H30(),
                  Text(
                    widget.mobileNumber,
                    style: GoogleFonts.aBeeZee(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const H30(),
                  _wrongNumber(width, () {
                    context.read<AuthBloc>().add(
                          ChangeMobileNumberEvent(),
                        );
                  }),
                  const H50(),
                  Pinput(
                    onCompleted: (pin) {
                      otp = pin;
                    },
                    onSubmitted: (value) {
                      otp = value;
                    },
                  ),
                  const H50(),
                  LoginButton(
                    width: width,
                    callback: () {
                      context.read<AuthBloc>().add(SubmitOtpEvent());
                    },
                    label: 'Submit OTP',
                  ),
                  const H30(),
                  TextButton(onPressed: () {}, child: const Text('Resend OTP'))
                ],
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return LoadingAnimation(isLoading: loading, height: height);
              },
            )
          ],
        ),
      );
    });
  }

  Widget _wrongNumber(double width, VoidCallback callback) {
    return TextButton(
      onPressed: callback,
      child: Text(
        'Change Mobile Number',
        style: GoogleFonts.aBeeZee(
          fontSize: width * 0.03,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
