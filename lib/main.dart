import "package:firebase_core/firebase_core.dart";
import "package:firebaseapp/core/di/app_injector.dart";
import "package:firebaseapp/core/navigation/app_router.dart";
import "package:firebaseapp/core/services/remote_config_service.dart";
import "package:firebaseapp/feature/auth/presentation/bloc/auth_bloc.dart";
import "package:firebaseapp/firebase_options.dart";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await AppInjector.setupInjector();
  final remoteConfigService = AppInjector.getIt<RemoteConfigService>();
  await remoteConfigService.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(final BuildContext context) => BlocProvider<AuthBloc>(
    create: (final BuildContext context) => AppInjector.getIt<AuthBloc>(),
    child: MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _appRouter.config(),
    ),
  );
}
