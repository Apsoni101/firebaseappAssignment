import 'package:equatable/equatable.dart';
import 'package:firebaseapp/feature/auth/domain/entities/user.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthLoaded extends AuthState {
  final UserEntity user;

  const AuthLoaded(this.user);

  @override
  List<Object> get props => [user];
}
