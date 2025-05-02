import 'package:firebaseapp/feature/posts/domain/entities/post.dart';
import 'package:firebaseapp/feature/posts/domain/repositories/post_repository.dart';

class PostUseCase {
  final PostRepository repository;

  PostUseCase(this.repository);

  Future<void> addPost(Post post) {
    return repository.addPost(post);
  }

  Stream<List<Post>> getPosts() {
    return repository.getPosts();
  }
}
