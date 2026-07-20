import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../feautures/auth/domain/entity/user.dart';
import '../../feautures/tasks/presentation/state/tasks_state.dart';
import 'widgets/dependencies_scope.dart';

class AuthorizedTasksScope extends StatelessWidget {
  final User user;
  final Widget child;

  const AuthorizedTasksScope({
    super.key,
    required this.user,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final dependencies = DependenciesScope.of(context)!.dependencies;

    return ChangeNotifierProvider(
      create: (_) {
        print("CREATE TASK CONTROLLER");

        return TasksController(
          taskRepository: dependencies.tasksRepository,
          userId: user.id,
        );
      },
      child: Builder(
        builder: (context) {
          print("initialized: ${context.read<TasksController>().toString()}");

          return child;
        },
      ),
    );
  }
}
