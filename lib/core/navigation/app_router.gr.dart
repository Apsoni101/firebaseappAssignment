


import 'package:auto_route/auto_route.dart' as _i4;
import 'package:firebaseapp/feature/auth/presentation/pages/login_page.dart'
    as _i1;
import 'package:firebaseapp/feature/auth/presentation/pages/register_page.dart'
    as _i3;
import 'package:firebaseapp/feature/posts/presentation/pages/posts_list_page.dart'
    as _i2;
import 'package:flutter/material.dart' as _i5;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.LoginPage(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
    PostsListRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PostsListPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterRouteArgs>(
          orElse: () => const RegisterRouteArgs());
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.RegisterPage(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
  };
}

class LoginRoute extends _i4.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i5.Key? key,
    void Function(bool)? onResult,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i4.PageInfo<LoginRouteArgs> page =
      _i4.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    this.onResult,
  });

  final _i5.Key? key;

  final void Function(bool)? onResult;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onResult: $onResult}';
  }
}

class PostsListRoute extends _i4.PageRouteInfo<void> {
  const PostsListRoute({List<_i4.PageRouteInfo>? children})
      : super(
          PostsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'PostsListRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

class RegisterRoute extends _i4.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    _i5.Key? key,
    void Function(bool)? onResult,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          RegisterRoute.name,
          args: RegisterRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i4.PageInfo<RegisterRouteArgs> page =
      _i4.PageInfo<RegisterRouteArgs>(name);
}

class RegisterRouteArgs {
  const RegisterRouteArgs({
    this.key,
    this.onResult,
  });

  final _i5.Key? key;

  final void Function(bool)? onResult;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key, onResult: $onResult}';
  }
}
