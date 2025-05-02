import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapp/feature/posts/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required String message,
    required String userId,
    required String username,
    required Timestamp timestamp,
  }) : super(
    message: message,
    userId: userId,
    username: username,
    timestamp: timestamp.toDate(),
  );

  Map<String, dynamic> toMap() => {
    'message': message,
    'userId': userId,
    'username': username,
    'timestamp': Timestamp.fromDate(timestamp),
  };
  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      message: map['message'] ?? '',
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      timestamp: map['timestamp'] as Timestamp,
    );
  }
  Post toEntity() {
    return Post(
      message: message,
      userId: userId,
      username: username,
      timestamp: timestamp,
    );
  }
  factory PostModel.fromEntity(Post post) {
    return PostModel(
      message: post.message,
      userId: post.userId,
      username: post.username,
      timestamp: Timestamp.fromDate(post.timestamp),
    );
  }
}
