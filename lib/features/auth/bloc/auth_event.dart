part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SendOtpEvent extends AuthState {}

class SubmitOtpEvent extends AuthState {}

class ResendOtpEvent extends AuthState {}
