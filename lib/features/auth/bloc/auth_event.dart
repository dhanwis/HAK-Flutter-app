part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String mobileNumber;

  const SendOtpEvent({required this.mobileNumber});

  @override
  List<Object> get props => [mobileNumber];
}

class SubmitOtpEvent extends AuthEvent {}

class ResendOtpEvent extends AuthEvent {}

class ChangeMobileNumberEvent extends AuthEvent{}
