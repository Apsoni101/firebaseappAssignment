part of 'post_bloc.dart';

@immutable
sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class AddPostEvent extends PostEvent {
  final String message;
  final String userId;
  final String username;

  const AddPostEvent(this.message, this.userId, this.username);

  @override
  List<Object?> get props => [message, userId, username];
}

class LoadPostsEvent extends PostEvent {
  const LoadPostsEvent();
}

class PostsUpdated extends PostEvent {
  final List<Post> posts;

  const PostsUpdated(this.posts);

  @override
  List<Object?> get props => [posts];
}
