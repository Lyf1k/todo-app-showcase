import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partfolio_app/core/initialization/auth_tasks_scope.dart';
import 'package:partfolio_app/core/routing/route_constants.dart';
import 'package:partfolio_app/feautures/auth/presentation/pages/login_screen.dart';
import 'package:partfolio_app/feautures/auth/presentation/pages/registration_screen.dart';
import 'package:partfolio_app/feautures/auth/presentation/state/auth_controller.dart';
import 'package:partfolio_app/feautures/settings/presentation/settings_screen.dart';
import 'package:partfolio_app/feautures/tasks/presentation/tasks_screen.dart';

import '../loader/loader_screen.dart';
import '../main_scaffold.dart';

class AppRouter extends ChangeNotifier {
  final AuthController authController;
  AppRouter({required this.authController});

  late final GoRouter goRoute = GoRouter(
    refreshListenable: authController,
    debugLogDiagnostics: true,
    initialLocation: '/loader',
    redirect: (context, state) {
      final status = authController.status;
      if (status == AuthStatus.unknown) return null;

      final isLoggedIn = authController.isLoggedIn;
      final currentPath = state.matchedLocation; // или state.uri.path

      final isALoader = currentPath == '/loader';
      final isGoingToAuthRoute =
          currentPath == '/login' || currentPath == '/register';

      if (isALoader) {
        return isLoggedIn ? '/homeScreen' : '/login';
      }
      if (!isLoggedIn && !isGoingToAuthRoute) return '/login';
      if (isLoggedIn && isGoingToAuthRoute) return '/homeScreen';
      return null;
    },
    routes: [
      GoRoute(
        path: '/loader',
        name: RouteConstants.loader,
        builder: (context, state) => LoaderScreen(),
      ),
      GoRoute(
        path: '/login',
        name: RouteConstants.login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: RouteConstants.register,
        builder: (context, state) => RegistrationScreen(),
      ),

      // ↓ вот тут вместо двух отдельных GoRoute — один StatefulShellRoute
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AuthorizedTasksScope(
            child: MainScaffold(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/homeScreen',
                name: RouteConstants.tasks,
                builder: (context, state) => TasksScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                name: RouteConstants.settings,
                builder: (context, state) => SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
