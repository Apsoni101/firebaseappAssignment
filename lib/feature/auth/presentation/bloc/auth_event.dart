import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class OnSignInEvent extends AuthEvent {
  final String email;
  final String password;

  const OnSignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password,];
}

class OnSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;

  const OnSignUpEvent({
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  List<Object> get props => [email, password, username];
}

class OnSignOutEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
