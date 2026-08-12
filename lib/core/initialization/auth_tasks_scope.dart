import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/auth/presentation/state/auth_controller.dart';
import '../../features/tasks/presentation/state/tasks_state.dart';
import 'widgets/dependencies_scope.dart';

class AuthorizedTasksScope extends StatelessWidget {
  final Widget child;

  const AuthorizedTasksScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final dependencies = DependenciesScope.of(context)!.dependencies;
    // final user = Provider.of<AuthController>(context).user;
    final authController = context.watch<AuthController>();
    final user = authController.user;
    print("AuthorizedTasksScope build, user = $user");
    return ChangeNotifierProvider(
      create: (_) {
        print("CREATE TASK CONTROLLER");

        return TasksController(
          notificationService: dependencies.notificationService,
          taskRepository: dependencies.tasksRepository,
          userId: user!.id,
        );
      },
      child: Builder(
        builder: (context) {
          return child;
        },
      ),
    );
  }
}
