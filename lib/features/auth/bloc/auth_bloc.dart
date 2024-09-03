import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/database_support/database_support.dart';
import 'package:dil_hack_e_commerce/features/auth/model/otp.dart';

import 'package:dil_hack_e_commerce/secrets/api_links.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:shared_preferences/shared_preferences.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SendOtpEvent>(_sendOtp);
    on<SubmitOtpEvent>(_submitOtp);
    //on<ChangeMobileNumberEvent>(_changeMobileNumber);
  }

  ApiLinks apiLinks = ApiLinks();
  String? _phoneNumber;
  String? _verificationSid;

  Future<void> _sendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    Dio dioClient = Dio();

    emit(OtpLoadingState());
    try {
      final response = await dioClient.post(
        '${AppConstants.BASE_URL}/auth_customer/customer/auth/login',
        data: {'phoneNumber': event.mobileNumber},
      );

      emit(AuthInitial());

      if (response.statusCode == 201) {
        final verificationSid = response.data['verificationSid'];

        _phoneNumber = event.mobileNumber;
        _verificationSid = verificationSid;

        DatabaseSupport.saveusername(event.mobileNumber);

        emit(OtpReceivedState(
            mobileNumber: event.mobileNumber,
            verificationSid: verificationSid));

        apiLinks.setId = verificationSid;
      }
    } catch (error) {
      emit(OtpSendingErrorState(msg: error.toString()));
    }
  }

  Future<void> _submitOtp(SubmitOtpEvent event, Emitter<AuthState> emit) async {
    if (_phoneNumber == null || _verificationSid == null) {
      emit(OtpValidatingErrorState());
      return;
    }

    Dio dioClient = Dio();

    SharedPreferences pref = await SharedPreferences.getInstance();
    emit(OtpLoadingState());
    try {
      String otp = event.otp;

      emit(OtpValidationWaitingState());

      final response = await dioClient.post(
        '${AppConstants.BASE_URL}/auth_customer/customer/auth/otp_verification',
        data: {
          "otp": otp,
          "phoneNumber": _phoneNumber,
          "verificationSid": _verificationSid,
        },
      );

      if (response.statusCode == 200) {
        final tokenData = AuthResponse.fromJson(response.data);

        await pref.setString('accessToken', tokenData.access!);
        await pref.setString('refreshToken', tokenData.refresh!);
        emit(OtpValidatedState(token: tokenData.access!));
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      emit(OtpValidatingErrorState());
    }
  }

  // Future<void> _changeMobileNumber(
  //     ChangeMobileNumberEvent event, Emitter<AuthState> emit) {
  //   emit(WrongMobileNumberState());
  // }
}
