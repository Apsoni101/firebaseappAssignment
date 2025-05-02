import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/feature/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String name,
    required String email,
  }) : super(id: id, name: name, email: email);

  factory UserModel.fromFirebaseUser(User user, String username) {
    return UserModel(
      id: user.uid,
      name: username,
      email: user.email ?? '',
    );
  }
  UserEntity toEntity() {
    return UserEntity(id: id, name: name, email: email);
  }
}
