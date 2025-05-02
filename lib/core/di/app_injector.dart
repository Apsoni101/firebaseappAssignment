import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebaseapp/core/navigation/authguard.dart';
import 'package:firebaseapp/core/services/remote_config_service.dart';
import 'package:firebaseapp/feature/auth/data/data_sources/auth_data_source.dart';
import 'package:firebaseapp/feature/auth/data/repositories/auth_repo_impl.dart';
import 'package:firebaseapp/feature/auth/domain/repositories/auth_repo.dart';
import 'package:firebaseapp/feature/auth/domain/use_cases/auth_usecase.dart';
import 'package:firebaseapp/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebaseapp/feature/posts/data/data_sources/post_remote_datasource.dart';
import 'package:firebaseapp/feature/posts/data/repositories/post_repository_impl.dart';
import 'package:firebaseapp/feature/posts/domain/repositories/post_repository.dart';
import 'package:firebaseapp/feature/posts/domain/use_cases/postusecase.dart';
import 'package:firebaseapp/feature/posts/presentation/bloc/post_bloc.dart';
import 'package:get_it/get_it.dart';

class AppInjector {
  AppInjector._();

  static final GetIt getIt = GetIt.instance;

  static Future<void> setupInjector() async {
    getIt
      ..registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance)
      ..registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance,
      )..registerLazySingleton<FirebaseRemoteConfig >(
        () => FirebaseRemoteConfig.instance,
      )

      ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
          firebaseAuth: getIt<FirebaseAuth>(),
          firestore: getIt<FirebaseFirestore>(),
        ),
      )
      ..registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
      )
      ..registerLazySingleton<AuthUseCase>(
        () => AuthUseCase(getIt<AuthRepository>()),
      )
      ..registerFactory<AuthBloc>(() => AuthBloc(getIt<AuthUseCase>()))

      ..registerLazySingleton<AuthGuard>(() => AuthGuard(getIt<AuthUseCase>()))
      ..registerLazySingleton<RemoteConfigService>(
            () => RemoteConfigService(remoteConfig: getIt<FirebaseRemoteConfig>()),
      )


      ..registerLazySingleton<PostRemoteDataSource>(
        () => PostRemoteDataSourceImpl(
          getIt<FirebaseFirestore>(),
          getIt<FirebaseAuth>(),
        ),
      )

      ..registerLazySingleton<PostRepository>(
        () => PostRepositoryImpl(getIt<PostRemoteDataSource>()),
      )
      ..registerLazySingleton<PostUseCase>(
        () => PostUseCase(getIt<PostRepository>()),
      )
      ..registerFactory<PostBloc>(() => PostBloc(getIt<PostUseCase>()));
  }
}
