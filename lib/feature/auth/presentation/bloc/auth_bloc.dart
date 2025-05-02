import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebaseapp/feature/auth/domain/use_cases/auth_usecase.dart';
import 'package:firebaseapp/feature/auth/presentation/bloc/auth_event.dart';
import 'package:firebaseapp/feature/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase authUseCases;

  AuthBloc(this.authUseCases) : super(AuthInitial()) {
    on<OnSignUpEvent>(_onSignUp);
    on<OnSignInEvent>(_onSignIn);
    on<OnSignOutEvent>(_onSignOut);
  }

  Future<void> _onSignUp(OnSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authUseCases.signUp(
      email: event.email,
      password: event.password,
      username: event.username,
    );


    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (userEntity) => emit(AuthAuthenticated(userEntity)),
    );;
  }

  Future<void> _onSignIn(OnSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authUseCases.signIn(
      email: event.email,
      password: event.password,
    );


    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (userEntity) => emit(AuthAuthenticated(userEntity)),
    );;
  }

  Future<void> _onSignOut(OnSignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authUseCases.signOut();

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (_) => emit(AuthInitial()),
    );
  }
}
