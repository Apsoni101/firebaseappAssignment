import 'package:firebaseapp/core/constants/app_strings.dart';
import 'package:firebaseapp/core/di/app_injector.dart';
import 'package:firebaseapp/feature/posts/presentation/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AddPostForm extends StatefulWidget {
  @override
  _AddPostFormState createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm> {
  final _controller = TextEditingController();

  void _submitMessage(BuildContext context) {
    final message = _controller.text.trim();
    final user = AppInjector.getIt<FirebaseAuth>().currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.loginRequired)),
      );
      return;
    }

    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.emptyMessage)),
      );
      return;
    }

    context.read<PostBloc>().add(
      AddPostEvent(
        message,
        user.uid,
        user.displayName ?? "Anonymous",
      ),
    );

    _controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: AppStrings.writeMessage,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.send),
              color: Theme.of(context).primaryColor,
              onPressed: () => _submitMessage(context),
            ),
          ],
        ),
      ),
    );
  }
}
