import "package:auto_route/auto_route.dart";
import "package:firebaseapp/core/di/app_injector.dart";
import "package:firebaseapp/core/navigation/app_router.gr.dart";
import "package:firebaseapp/feature/auth/domain/use_cases/auth_usecase.dart";
import "package:firebaseapp/feature/auth/presentation/bloc/auth_bloc.dart";

import "authguard.dart";

@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(
      page: PostsListRoute.page,
      guards: [AuthGuard(AppInjector.getIt<AuthUseCase>())],
    ),
  ];
}
