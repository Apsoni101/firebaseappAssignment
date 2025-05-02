import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/core/error/failure.dart';
import 'package:firebaseapp/feature/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signUp(String email, String password, String username);
  Future<Either<Failure, UserEntity>> signIn(String email, String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, String>> getUsername(String uid);
  Future<Either<Failure, UserEntity>> isUserAuthenticated();

}
