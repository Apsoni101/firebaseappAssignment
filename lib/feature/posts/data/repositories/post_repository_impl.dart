import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapp/feature/posts/data/data_sources/post_remote_datasource.dart';
import 'package:firebaseapp/feature/posts/data/models/post_model.dart';
import 'package:firebaseapp/feature/posts/domain/entities/post.dart';
import 'package:firebaseapp/feature/posts/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addPost(Post post) {
    return remoteDataSource.addPost(PostModel.fromEntity(post));
  }

  @override
  Stream<List<Post>> getPosts() {
    return remoteDataSource.getPosts();
  }

}
