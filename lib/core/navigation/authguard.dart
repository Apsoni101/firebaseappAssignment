import 'package:auto_route/auto_route.dart';
import 'package:firebaseapp/core/di/app_injector.dart';
import 'package:firebaseapp/core/error/failure.dart';
import 'package:firebaseapp/feature/auth/domain/use_cases/auth_usecase.dart';

import 'app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthUseCase authUseCase ;
  AuthGuard(this.authUseCase);

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final result = await authUseCase.isUserAuthenticated();

    result.fold(
          (Failure failure) async {
        await router.push(
          LoginRoute(
            onResult: (success) {
              if (success) {
                resolver.next(true);
              } else {
                resolver.next(false);
              }
            },
          ),
        );
      },
          (user) {
        resolver.next(true);
      },
    );
  }
}
