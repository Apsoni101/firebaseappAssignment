import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebaseapp/feature/posts/domain/entities/post.dart';
import 'package:firebaseapp/feature/posts/domain/use_cases/postusecase.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostUseCase postUseCase;

  PostBloc(this.postUseCase) : super(PostInitial()) {
    on<AddPostEvent>(_onAddPost);
    on<LoadPostsEvent>(_onLoadPosts);
    on<PostsUpdated>(_onPostsUpdated);
  }

  Future<void> _onAddPost(AddPostEvent event, Emitter<PostState> emit) async {
    try {
      emit(PostLoading());
      await postUseCase.addPost(Post(
        message: event.message,
        userId: event.userId,
        username: event.username,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  void _onLoadPosts(LoadPostsEvent event, Emitter<PostState> emit) {
    emit(PostLoading());
    postUseCase.getPosts().listen(
          (posts) => add(PostsUpdated(posts)),
      onError: (e) => emit(PostError(e.toString())),
    );
  }

  void _onPostsUpdated(PostsUpdated event, Emitter<PostState> emit) {
    emit(PostLoaded(event.posts));
  }
}
