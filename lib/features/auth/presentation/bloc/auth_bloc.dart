import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/entities/user_entity.dart';
import '../../domain/usecases/get_user_data.dart';
import '../../domain/usecases/sign_in_with_email_password.dart';
import '../../domain/usecases/sign_out.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmailPassword _signInWithEmailPassword;

  final SignOut _signOut;
  final GetUserData _getUserData;

  AuthBloc({
    required SignInWithEmailPassword signInWithEmailPassword,
    required SignOut signOut,
    required GetUserData getUserData,
  })  : _signInWithEmailPassword = signInWithEmailPassword,
        _signOut = signOut,
        _getUserData = getUserData,
        super(AuthInitial()) {
    on<SignInWithEmailPasswordEvent>(_onSignInWithEmailPasswordEvent);
    on<SignOutEvent>(_onSignOutEvent);
    on<GetUserDataEvent>(_onGetUserDataEvent);
  }

  void _onSignInWithEmailPasswordEvent(
    SignInWithEmailPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signInWithEmailPassword.execute(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) {
        emit(AuthErrorState(message: failure.message));
      },
      (_) => emit(SignedInSuccessfullyState()),
    );
  }

  void _onSignOutEvent(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signOut.execute();

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (_) => emit(SignOutSuccessfullyState()),
    );
  }

  void _onGetUserDataEvent(
    GetUserDataEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _getUserData.execute();

    result.fold(
      (failure) {
        emit(AuthErrorState(message: failure.message));
      },
      (userData) {
        return userData != null
            ? emit(UserDataExistsState(userData: userData))
            : emit(UserDataDoesNotExistsState());
      },
    );
  }
}
