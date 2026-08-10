import 'package:flutter/material.dart';

import '../../feautures/auth/domain/entity/user.dart';
import '../../feautures/auth/presentation/pages/login_screen.dart';
import '../../feautures/tasks/presentation/bottom_navigation_bar.dart';
import 'auth_tasks_scope.dart';
import 'widgets/dependencies_scope.dart';

class AuthGate extends StatefulWidget {
  final VoidCallback checkUser;
  const AuthGate({super.key, required this.checkUser});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {

  @override
  initState() {
    widget.checkUser();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final auth = DependenciesScope.of(
      context,
    )!.dependencies.authenticationRepository;
    return StreamBuilder<User?>(
      stream: auth.userStream,
      builder: (_, snapshot) {
        if (!snapshot.hasData && snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator(),),);
          // return AnimatedSwitcher(
          //   transitionBuilder: (Widget child, Animation<double> animation) {
          //     return FadeTransition(opacity: animation,
          //     child: child);
          //   },
          //   duration: const Duration(milliseconds: 800),
          //   child: const LoginScreen(key: ValueKey("login")),
          // );
        }
        return snapshot.data != null ? AnimatedSwitcher(
          duration: Duration(milliseconds: 800),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: AuthorizedTasksScope(
            key: ValueKey(snapshot.data!.id),
            user: snapshot.data!,
            child: const HomeScreen(key: ValueKey("key")),
          ),
        )
        : AnimatedSwitcher(
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation,
              child: child);
            },
            duration: const Duration(milliseconds: 800),
            child: const LoginScreen(key: ValueKey("login")),
          );

        
      },
    );
  }
}
