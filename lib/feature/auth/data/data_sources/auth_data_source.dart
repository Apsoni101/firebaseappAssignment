import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import "package:firebaseapp/core/error/failure.dart";
import 'package:firebaseapp/feature/auth/data/models/user_model.dart';
import 'package:firebaseapp/feature/auth/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, User>> signUp(
      String email,
      String password,
      String username,
      );

  Future<Either<Failure, User>> signIn(String email, String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, String>> getUsername(String uid);
  Future<Either<Failure, UserModel>> isUserAuthenticated();

}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<Either<Failure, User>> signUp(
      String email,
      String password,
      String username,
      ) async {
    try {
      final userCred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCred.user!;
      await firestore.collection('users').doc(user.uid).set({
        'username': username,
        'email': email,
      });
      return Right(user);
    } catch (e) {
      return Left(Failure(-1, e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signIn(String email, String password) async {
    try {
      final userCred = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCred.user!);
    } catch (e) {
      return Left(Failure(-1, e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(Failure(-1, e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getUsername(String uid) async {
    try {
      final doc = await firestore.collection('users').doc(uid).get();
      final username = doc.data()?['username'] ?? '';
      return Right(username);
    } catch (e) {
      return Left(Failure(-1, e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> isUserAuthenticated() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        final doc = await firestore.collection('users').doc(user.uid).get();
        final username = doc.data()?['username'] ?? '';
        final userModel = UserModel.fromFirebaseUser(user, username);
        return Right(userModel);
      } else {
        return Left(Failure(-1, "User not authenticated"));
      }
    } catch (e) {
      return Left(Failure(-1, e.toString()));
    }
  }


}
