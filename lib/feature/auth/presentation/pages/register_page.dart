import 'package:auto_route/auto_route.dart';
import 'package:firebaseapp/core/constants/app_strings.dart';
import 'package:firebaseapp/core/constants/app_text_styles.dart';
import 'package:firebaseapp/core/navigation/app_router.gr.dart';
import 'package:firebaseapp/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebaseapp/feature/auth/presentation/bloc/auth_event.dart';
import 'package:firebaseapp/feature/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  final void Function(bool success)? onResult;

  const RegisterPage({super.key, this.onResult});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.enterEmail;
    }
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) {
      return AppStrings.validEmail;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.enterpassword;
    }
    if (value.length < 6) {
      return AppStrings.validpassword;
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.fullnamerequired;
    }
    return null;
  }

  void _register(final BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      final String name = nameController.text.trim();

      context.read<AuthBloc>().add(
        OnSignUpEvent(email: email, password: password, username: name),
      );
    }
  }

  @override
  Widget build(final BuildContext context) => BlocConsumer<AuthBloc, AuthState>(
    listener: (final BuildContext context, final AuthState state) {
      if (state is AuthAuthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.regsuccess)),
        );
        if (widget.onResult != null) {
          widget.onResult!(true);
        } else {
          context.router.replaceAll([const PostsListRoute()]);
        }


      }
    },
    builder: (final BuildContext context, final AuthState state) {
      final bool isLoading = state is AuthLoading;

      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppStrings.register,
                    style: AppTextStyles.register,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.name,
                      border: OutlineInputBorder(),
                    ),
                    validator: _validateName,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: AppStrings.password,
                      border: OutlineInputBorder(),
                    ),
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => _register(context),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(AppStrings.register),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.router.replace( LoginRoute());
                      },
                      child: const Text(AppStrings.login),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
