import 'package:firebaseapp/feature/posts/domain/entities/post.dart';

abstract class PostRepository {
  Future<void> addPost(Post post);
  Stream<List<Post>> getPosts();
}
