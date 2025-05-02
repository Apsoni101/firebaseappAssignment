import 'package:dartz/dartz.dart';
import 'package:firebaseapp/core/error/failure.dart';
import 'package:firebaseapp/feature/auth/domain/entities/user.dart';
import 'package:firebaseapp/feature/auth/domain/repositories/auth_repo.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String username,
  }) {
    return repository.signUp(email, password, username);
  }

  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) {
    return repository.signIn(email, password);
  }

  Future<Either<Failure, void>> signOut() {
    return repository.signOut();
  }

  Future<Either<Failure, String>> getUsername(String uid) {
    return repository.getUsername(uid);
  }
  Future<Either<Failure, UserEntity>> isUserAuthenticated() {
    return repository.isUserAuthenticated();
  }

}
