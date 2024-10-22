import 'package:go_router/go_router.dart';
import 'package:pets_app_mobile/core/routes/app_routes.dart';
import 'package:pets_app_mobile/views/auth/login_page.dart';
import 'package:pets_app_mobile/views/auth/welcome_page.dart';

import '../blocs/blocs.dart';

GoRouter appRouter(AuthenticationState state) => GoRouter(
      initialLocation: state.status == AuthenticationStatus.authenticated
          ? AppRoutes.welcome
          : AppRoutes.login,
      routes: publicRoutes(),
    );

List<RouteBase> publicRoutes() => [
      GoRoute(
          path: AppRoutes.welcome,
          builder: (context, state) => const WelcomePage()),
      GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const LoginPage()),
    ];
