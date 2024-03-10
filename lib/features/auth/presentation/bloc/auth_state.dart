part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class SignedInSuccessfullyState extends AuthState {}

class UserDataExistsState extends AuthState {
  final UserEntity userData;
  UserDataExistsState({required this.userData});
}

class UserDataDoesNotExistsState extends AuthState {}

class SignOutSuccessfullyState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState({required this.message});
}
