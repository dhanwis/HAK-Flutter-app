import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
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
    on<ChangeMobileNumberEvent>(_changeMobileNumber);
  }

  FutureOr<void> _sendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(
      OtpLoadingState(),
    );
    Dio dioClient = Dio();
    try {
      final url = ApiLinks.createUser;
      log('calling api');
      final response =
          await dioClient.post(url, data: {'phone_number': event.mobileNumber});
      emit(AuthInitial());
      if (response.statusCode == 201) {
        final id = response.data['id'];
        emit(OtpReceivedState(mobileNumber: event.mobileNumber));
        ApiLinks apiLinks = ApiLinks();
        apiLinks.setId = id;
      }
      if (response.statusCode == 500) {
        log('status 500');
        log('response : ${response.data}');
      }
    } catch (error) {
      emit(OtpSendingErrorState());
      log(
        error.toString(),
      );
    }
  }

  FutureOr<void> _submitOtp(
      SubmitOtpEvent event, Emitter<AuthState> emit) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Dio dioClient = Dio();
    emit(
      OtpLoadingState(),
    );
    try {
      emit(OtpValidationWaitingState());

      final response = await dioClient.patch(
        'https://hak.pythonanywhere.com/auth/customer/$id/verify-otp/',
        data: {"otp": 'otp'},
      );
      if (response.data == 200 || response.statusCode == 201) {
        final tokenData = AuthResponse.fromJson(response.data);

        log(tokenData.access!);
        await pref.setString('accessToken', tokenData.access!);
        await pref.setString('refreshToken', tokenData.refresh!);
        emit(OtpValidatedState(token: tokenData.access!));

        // log('access token: $accessToken');
        // log(response.data['refresh']);
        // log(response.data['access']);
        // log(response.data['otp']);
        // log(response.data['message']);
      }
    } catch (e) {
      emit(OtpValidatingErrorState());

      log(
        e.toString(),
      );
    }
  }

  FutureOr<void> _changeMobileNumber(
      ChangeMobileNumberEvent event, Emitter<AuthState> emit) {
    emit(WrongMobileNumberState());
  }
}
