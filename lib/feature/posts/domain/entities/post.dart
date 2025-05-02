import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String message;
  final String userId;
  final String username;
  final DateTime timestamp;

  const Post({
    required this.message,
    required this.userId,
    required this.username,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [message, userId, username, timestamp];
}
