import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/feature/posts/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<void> addPost(PostModel post);
  Stream<List<PostModel>> getPosts();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  PostRemoteDataSourceImpl(this.firestore, this.auth);

  @override
  Future<void> addPost(PostModel post) async {
    final user = auth.currentUser;
    if (user == null) throw Exception("Not authenticated");
    await firestore.collection('posts').add(post.toMap());
  }

  @override
  Stream<List<PostModel>> getPosts() {
    return firestore
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => PostModel.fromMap(doc.data())).toList());
  }
}
