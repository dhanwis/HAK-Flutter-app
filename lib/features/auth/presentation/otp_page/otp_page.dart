import 'package:dil_hack_e_commerce/core/sized_boxes.dart';
import 'package:dil_hack_e_commerce/core/theme/loading_dilhak.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/auth_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/login_page/login_page.dart';

import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/login_button.dart';
import 'package:dil_hack_e_commerce/features/hak_bottom_bar/bottom_bar.dart';
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

  // @override
  // void initState() {
  //   super.initState();
  //   // Retrieve tokens from Hive
  //   var tokenBox = Hive.box<Token>('tokenBox');
  //   Token tokens = tokenBox.get('tokens') ?? Token("", "");
  //   accessToken = tokens.accessToken;
  //   refreshToken = tokens.refreshToken;
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    bool loading = false;
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpValidatedState) {
          Future.delayed(const Duration(milliseconds: 300), () {
            Navigator.pushAndRemoveUntil(context,
                createRoute(const DilHackBottomNavBar()), (route) => false);
          });
          Future.delayed(Duration.zero, () {
            ScaffoldMessenger.of(context).showSnackBar(
              // SnackBar(
              //   // ignore: use_build_context_synchronously
              //   content: IconSnackBar.show(context,
              //       label: 'OTP validated SuccessFully',
              //       snackBarType: SnackBarType.success),
              // ),
              SnackBar(
                content: Text('OTP validated SuccessFully'),
                backgroundColor: Palette.appTheme,
                duration: Duration(seconds: 1), // Set the duration to 1 second
              ),
            );
          });
        }
        if (state is OtpValidatingErrorState) {
          Navigator.push(
            context,
            createRoute(
              const LoginPage(),
            ),
          );
        }
        if (state is WrongMobileNumberState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is OtpValidationWaitingState) {
          loading = true;
        } else {
          loading = false;
        }

        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'OTP Verification',
                          style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.07),
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
                        // LoginButton(
                        //   width: width,
                        //   callback: () {
                        //     // Save Tokens to Hive
                        //     // var tokenBox = Hive.box<Token>('tokenBox');
                        //     // tokenBox.put(
                        //     //     'tokens', Token(accessToken, refreshToken));

                        //     context
                        //         .read<AuthBloc>()
                        //         .add(SubmitOtpEvent(otp: otp));

                        //     () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 DilHackBottomNavBar()),
                        //       );
                        //     };
                        //   },
                        //   label: 'Submit OTP',
                        // ),

                        LoginButton(
                          width: width,
                          callback: () {
                            context
                                .read<AuthBloc>()
                                .add(SubmitOtpEvent(otp: otp));
                          },
                          label: 'Submit OTP',
                        ),

                        const H30(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DilHackBottomNavBar()),
                            );
                          },
                          child: const Text('Resend OTP'),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return LoadingAnimation(
                          isLoading: loading, height: height);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _wrongNumber(double width, VoidCallback callback) {
    return TextButton(
      onPressed: callback,
      child: Text(
        'Change Mobile Number',
        style: GoogleFonts.aBeeZee(
            fontSize: width * 0.03,
            color: Colors.blue,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
