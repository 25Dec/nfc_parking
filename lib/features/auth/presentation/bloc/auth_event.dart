part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SendOtpEvent extends AuthEvent {
  final String phoneNumber;

  SendOtpEvent({required this.phoneNumber});
}

class VerifyOtpAndSignInEvent extends AuthEvent {
  final String otp;

  VerifyOtpAndSignInEvent({required this.otp});
}

class SignInWithEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailPasswordEvent({
    required this.email,
    required this.password,
  });
}

class RegisterAccountEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;

  RegisterAccountEvent({
    required this.fullName,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });
}

class GetUserDataEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
