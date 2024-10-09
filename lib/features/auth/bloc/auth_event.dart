part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class SendOtpEvent extends AuthEvent {
  final String mobileNumber;

  const SendOtpEvent({required this.mobileNumber});

  @override
  List<Object> get props => [mobileNumber];
}

class SubmitOtpEvent extends AuthEvent {
  final String otp;
  //final String userId;

  const SubmitOtpEvent({
    required this.otp,
    // required this.userId,
  });
  @override
  List<Object> get props => [otp];
}

class ResendOtpEvent extends AuthEvent {}

class ChangeMobileNumberEvent extends AuthEvent {}
