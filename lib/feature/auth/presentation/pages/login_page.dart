import 'package:auto_route/auto_route.dart';
import 'package:firebaseapp/core/constants/app_strings.dart';
import 'package:firebaseapp/core/navigation/app_router.gr.dart';
import 'package:firebaseapp/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebaseapp/feature/auth/presentation/bloc/auth_event.dart';
import 'package:firebaseapp/feature/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  final void Function(bool success)? onResult;

  const LoginPage({super.key, this.onResult});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(final BuildContext context) {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    context.read<AuthBloc>().add(
      OnSignInEvent(
        email: email,
        password: password,
      ),
    );
  }


  @override
  Widget build(final BuildContext context) => BlocConsumer<AuthBloc, AuthState>(
    listener: (final BuildContext context, final AuthState state) {
      if (state is AuthAuthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful")),
        );
        if (widget.onResult != null) {
          widget.onResult!(true);
        } else {
          context.router.replaceAll([ PostsListRoute()]);
        }
      } else if (state is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );

      }
    },
    builder: (final BuildContext context, final AuthState state) => Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enterEmail;
                    }
                    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                      return AppStrings.validEmail;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: AppStrings.password,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enterpassword;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (state is! AuthLoading) {
                          _login(context);
                        }
                      }
                    },
                    child: const Text(AppStrings.login)

                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () => context.router.replace( RegisterRoute()),
                    child: const Text(AppStrings.register),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
