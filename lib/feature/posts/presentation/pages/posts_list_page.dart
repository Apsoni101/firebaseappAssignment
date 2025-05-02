import 'package:auto_route/auto_route.dart';
import 'package:firebaseapp/core/constants/app_strings.dart';
import 'package:firebaseapp/core/constants/app_text_styles.dart';
import 'package:firebaseapp/core/di/app_injector.dart';
import 'package:firebaseapp/core/services/remote_config_service.dart';
import 'package:firebaseapp/feature/posts/presentation/widgets/add_post_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebaseapp/feature/posts/presentation/bloc/post_bloc.dart';

@RoutePage()
class PostsListPage extends StatelessWidget {
   const PostsListPage({super.key});
   @override
  Widget build(BuildContext context) {
     final remoteConfigService = AppInjector.getIt<RemoteConfigService>();
     final isPostingEnabled = remoteConfigService.isPostingEnabled;
    return BlocProvider(
      create: (context) => AppInjector.getIt<PostBloc>()..add(LoadPostsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text(AppStrings.publicfeed)),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  return switch (state) {
                    PostLoading() => const Center(child: CircularProgressIndicator()),
                    PostLoaded(:final posts) => ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (_, index) {
                        final post = posts[index];
                        return ListTile(
                          title: Text(post.username),
                          subtitle: Text(post.message),
                          trailing: Text(
                            post.timestamp.toLocal().toString(),
                            style: AppTextStyles.trailing,
                          ),
                        );
                      },
                    ),
                    PostError(:final message) => Center(child: Text(message)),
                    _ => const Center(child: Text(AppStrings.noPost)),
                  };
                },
              ),
            ),
            if (isPostingEnabled)
               AddPostForm()
            else
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Posting is currently disabled",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
