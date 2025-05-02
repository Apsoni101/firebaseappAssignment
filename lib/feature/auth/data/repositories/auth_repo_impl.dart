import 'package:dartz/dartz.dart';
import 'package:firebaseapp/core/error/failure.dart';
import 'package:firebaseapp/feature/auth/data/data_sources/auth_data_source.dart';
import 'package:firebaseapp/feature/auth/data/models/user_model.dart';
import 'package:firebaseapp/feature/auth/domain/entities/user.dart';
import 'package:firebaseapp/feature/auth/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> signUp(String email, String password, String username) async {
    final result = await remoteDataSource.signUp(email, password, username);
    return result.fold(
          (failure) => Left(failure),
          (user) => Right(UserModel.fromFirebaseUser(user, username).toEntity()),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(String email, String password) async {
    final result = await remoteDataSource.signIn(email, password);

    return result.fold(
          (failure) => Left(failure),
          (user) async {
        final usernameResult = await getUsername(user.uid);
        return usernameResult.fold(
              (failure) => Left(failure),
              (username) => Right(UserModel.fromFirebaseUser(user, username).toEntity()),
        );
      },
    );
  }

  @override
  Future<Either<Failure, void>> signOut() {
    return remoteDataSource.signOut();
  }

  @override
  Future<Either<Failure, String>> getUsername(String uid) {
    return remoteDataSource.getUsername(uid);
  }
  @override
  Future<Either<Failure, UserEntity>> isUserAuthenticated() async {
    final result = await remoteDataSource.isUserAuthenticated();
    return result.fold(
          (failure) => Left(failure),
          (userModel) => Right(userModel.toEntity()),
    );
  }

}
