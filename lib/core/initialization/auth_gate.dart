import 'package:flutter/material.dart';

import '../../feautures/auth/domain/entity/user.dart';
import '../../feautures/auth/presentation/pages/login_screen.dart';
import '../../feautures/tasks/presentation/bottom_navigation_bar.dart';
import 'auth_tasks_scope.dart';
import 'widgets/dependencies_scope.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    final auth = DependenciesScope.of(
      context,
    )!.dependencies.authenticationRepository;

    return StreamBuilder<User?>(
      stream: auth.userStream,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return AnimatedSwitcher(
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            duration: const Duration(milliseconds: 500),
            child: const LoginScreen(key: ValueKey("login")),
          );
        }

        return AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: AuthorizedTasksScope(
            key: ValueKey(snapshot.data!.id),
            user: snapshot.data!,
            child: const HomeScreen(key: ValueKey("key")),
          ),
        );
      },
    );
  }
}
