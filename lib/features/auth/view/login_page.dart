import 'package:dil_hack_e_commerce/core/const/snackbar.dart';
import 'package:dil_hack_e_commerce/core/sized_boxes.dart';
import 'package:dil_hack_e_commerce/core/theme/loading_dilhak.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/auth_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/view/otp_page/otp_page.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/login_image.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/dil_hack_grey_logo.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/login_button.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/login_field.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/otp_text.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/powered_by.dart';
import 'package:dil_hack_e_commerce/features/auth/view/widgets/verify_text.dart';
import 'package:dil_hack_e_commerce/helpers/animated_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is OtpReceivedState) {
            Navigator.push(
              context,
              createRoute(
                EnterOtpPage(mobileNumber: state.mobileNumber),
              ),

            );
          }
          if(state is OtpSendingErrorState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('errro')));
          }
        },
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    LoginImage(height: height, width: width),
                    VerifyText(width: width),
                    OtpText(width: width),
                    OtpTextField(
                      width: width,
                      controller: mobileNumberController,
                    ),
                    const H30(),
                    LoginButton(
                      label: 'Send OTP',
                      width: width,
                      callback: () {
                        if (_formKey.currentState!.validate()) {
                          authBloc.add(
                            SendOtpEvent(
                              mobileNumber: mobileNumberController.text,
                            ),
                          );
                          SnackBars.otpSendBar(
                              context, mobileNumberController.text);
                        }
                      },
                    ),
                    const H30(),
                    const PoweredByText(),
                    const DhanwisTechLogo()
                  ],
                ),
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final loading = state is OtpLoadingState;
                  return LoadingAnimation(
                    height: height,
                    isLoading: loading,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
