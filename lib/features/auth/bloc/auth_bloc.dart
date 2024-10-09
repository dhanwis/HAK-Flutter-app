import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/userId.dart';
import 'package:dil_hack_e_commerce/database_support/database_support.dart';
import 'package:dil_hack_e_commerce/features/auth/model/otp.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/otp_page/tokenStorage.dart';

import 'package:dil_hack_e_commerce/secrets/api_links.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    //on<AppStarted>(_onAppStarted);
    on<SendOtpEvent>(_sendOtp);
    on<SubmitOtpEvent>(_submitOtp);
    //on<ChangeMobileNumberEvent>(_changeMobileNumber);
  }

  ApiLinks apiLinks = ApiLinks();
  String? _phoneNumber;
  String? _verificationSid;

  // Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
  //   await UserIdProvider
  //       .initializeUserId(); // Initialize the user ID from the token

  //   if (UserIdProvider.userId != null) {
  //     emit(AuthAuthenticated(userId: UserIdProvider.userId!));
  //   } else {
  //     emit(AuthUnauthenticated());
  //   }
  // }

  Future<void> _sendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    Dio dioClient = Dio();

    emit(OtpLoadingState());
    try {
      final response = await dioClient.post(
        '${AppConstants.BASE_URL}/auth_customer/auth/login',
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
    final tokenStorage = TokenStorage();

    if (_phoneNumber == null || _verificationSid == null) {
      emit(OtpValidatingErrorState());
      return;
    }

    Dio dioClient = Dio();

    emit(OtpLoadingState());
    try {
      String otp = event.otp;
      emit(OtpValidationWaitingState());

      final response = await dioClient.post(
        '${AppConstants.BASE_URL}/auth_customer/auth/otp_verification',
        data: {
          "otp": otp,
          "phoneNumber": _phoneNumber,
          "verificationSid": _verificationSid,
        },
      );

      if (response.statusCode == 200) {
        final tokenData = AuthResponse.fromJson(response.data);

        String? accessToken = tokenData.access;
        String? refreshToken = tokenData.refresh;

        await tokenStorage.saveTokens(accessToken!, refreshToken!);

        emit(OtpValidatedState(token: accessToken));
        //emit(AuthAuthenticated(userId: event.userId));
        print('OtpValidatedState emitted');
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      emit(OtpValidatingErrorState());
    }
  }

  Future<String> refreshToken(String refreshToken) async {
    Dio dioClient = Dio();

    final response = await dioClient.post(
      '${AppConstants.BASE_URL}/token',
      data: {'token': refreshToken},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.data)['accessToken'];
      // final tokenData = AuthResponse.fromJson(response.data);
      //return AuthResponse.fromJson(response.data)['accessToken'];
    } else {
      throw Exception('Failed to refresh Token');
    }
  }

  // Future<void> _changeMobileNumber(
  //     ChangeMobileNumberEvent event, Emitter<AuthState> emit) {
  //   emit(WrongMobileNumberState());
  // }
}
