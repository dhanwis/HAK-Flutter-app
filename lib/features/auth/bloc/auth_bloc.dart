import 'dart:async';
import 'dart:math';
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
  ApiLinks apiLinks = ApiLinks();

  FutureOr<void> _sendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    Dio dioClient = Dio();

    emit(
      OtpLoadingState(),
    );
    try {
      final response = await dioClient.post(
          //'https://hak-server-side.onrender.com/customers/auth/login',
          'http://192.168.1.43:8000/customers/auth/login',
          data: {'phoneNumber': event.mobileNumber});
      emit(AuthInitial());
      print('success');

      if (response.statusCode == 201) {
        final id = response.data['id'];
        emit(
          //manjima
          OtpReceivedState(mobileNumber: event.mobileNumber),
        );
        apiLinks.setId = id;
      }
    } catch (error) {
      print('failed');

      emit(
        OtpSendingErrorState(
          msg: error.toString(),
        ),
      );
    }
  }

  FutureOr<void> _submitOtp(
    SubmitOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    Dio dioClient = Dio();

    SharedPreferences pref = await SharedPreferences.getInstance();
// already generated id
    final id = apiLinks.id;
    emit(
      OtpLoadingState(),
    );
    try {
      String otp = event.otp;
      //   log('otp : $otp');
      // log('Id :$id');

      emit(
        OtpValidationWaitingState(),
      );
      // we will get the user details here
      final response = await dioClient.post(
        // 'https://hak-server-side.onrender.com/customers/auth/otp_verification',
        'http://192.168.1.43:8000/customers/auth/otp_verification',
        data: {"otp": otp},
      );

      if (response.statusCode == 200) {
        final tokenData = AuthResponse.fromJson(response.data);
        print(response.data);

        //log(tokenData.access!);
        // save the tokens in shared preference data base
        await pref.setString('accessToken', tokenData.access!);
        await pref.setString('refreshToken', tokenData.refresh!);
        emit(OtpValidatedState(token: tokenData.access!));
      } else {
        // Handle unexpected status codes
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle DioException and other errors
      emit(OtpValidatingErrorState());
      //   log(e.toString());
    }
  }

  FutureOr<void> _changeMobileNumber(
      ChangeMobileNumberEvent event, Emitter<AuthState> emit) {
    emit(WrongMobileNumberState());
  }
}
