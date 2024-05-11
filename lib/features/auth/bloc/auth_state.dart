part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class OtpLoadingState extends AuthBloc {}

class OtpSendedState extends AuthState {}

class OtpSubmittedState extends AuthState {}

class OtpValidatedState extends AuthState {}

