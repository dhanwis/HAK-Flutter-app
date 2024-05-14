part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}


class OtpLoadingState extends AuthState {}

class OtpSendedState extends AuthState {}

class OtpSendingErrorState extends AuthState {
  final String msg;

  OtpSendingErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}

class OtpValidatingErrorState extends AuthState {}

class WrongMobileNumberState extends AuthState{
  
}

class OtpReceivedState extends AuthState {
  final String mobileNumber;

  const OtpReceivedState({required this.mobileNumber});
}

class OtpSubmittedState extends AuthState {}

class OtpValidationWaitingState extends AuthState {}

class OtpValidatedState extends AuthState {
  final String token;

  const OtpValidatedState({required this.token});
  @override
  List<Object> get props => [token];
}
