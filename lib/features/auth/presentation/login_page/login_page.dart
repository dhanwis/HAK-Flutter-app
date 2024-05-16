import 'package:dil_hack_e_commerce/core/const/snackbar.dart';
import 'package:dil_hack_e_commerce/core/sized_boxes.dart';
import 'package:dil_hack_e_commerce/core/theme/loading_dilhak.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/auth_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/otp_page/otp_page.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/login_image.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/dil_hack_grey_logo.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/login_button.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/login_field.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/otp_text.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/powered_by.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/verify_text.dart';
import 'package:dil_hack_e_commerce/helpers/animated_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    mobileNumberController.dispose();
    super.dispose();
  }
  void _handleFormSubmit(AuthBloc authBloc) {
    if (_formKey.currentState!.validate()) {
      authBloc.add(SendOtpEvent(mobileNumber: mobileNumberController.text));
      SnackBars.otpSendBar(context, mobileNumberController.text);
    }
  }
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is OtpReceivedState) {
            Navigator.push(
              context,
              createRoute(
                EnterOtpPage(mobileNumber: state.mobileNumber),
              ),
            );
          }
          if (state is OtpSendingErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              IconSnackBar.show(
                context,
                label: state.msg,
                snackBarType: SnackBarType.fail,
              ),
            );
          }
        },
        builder: (context, state) {
          final loading = state is OtpLoadingState;

          return Scaffold(
            body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Stack(
                children: [
                  _buildForm(height, width, authBloc, loading),
                  LoadingAnimation(
                    height: height,
                    isLoading: loading,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildForm(
      double height, double width, AuthBloc authBloc, bool loading) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          LoginImage(height: height, width: width),
          const H30(),
          VerifyText(width: width),
          OtpText(width: width),
          const H30(),
          OtpTextField(
            width: width,
            controller: mobileNumberController,
          ),
          const H30(),
          LoginButton(
            label: 'Send OTP',
            width: width,
            callback: () => _handleFormSubmit(authBloc),
          ),
          const H30(),
          const PoweredByText(),
          const DhanwisTechLogo(),
        ],
      ),
    );
  }
}
