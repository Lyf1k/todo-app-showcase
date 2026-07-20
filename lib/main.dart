import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/initialization/auth_gate.dart';
import 'core/initialization/models/dependencies_container.dart';
import 'core/initialization/widgets/dependencies_scope.dart';
import 'core/service/auth_service.dart';
import 'feautures/auth/data/data_source/local_auth_datasource_impl.dart';
import 'feautures/auth/data/mapper/user_mapper.dart';
import 'feautures/auth/data/repository/authentication_repository_impl.dart';
import 'feautures/tasks/data/datasource/local_tasks_data_source_impl.dart';
import 'feautures/tasks/data/mapper/tasks_mapper.dart';
import 'feautures/tasks/data/repository/local_tasks_repository_impl.dart';

void main() {
  final authService = AuthService();
  final sharedPreferences = SharedPreferencesAsync();
  // Add: Dependencies container

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DependenciesScope(
      dependencies: DependenciesContainer(
        tasksRepository: TasksRepositoryImpl(
          dataSource: LocalTasksDataSourceImpl(
            sharedPreferences: sharedPreferences,
          ),
          tasksMapper: TasksMapper(),
        ),
        authService: authService,
        sharedPreferencesAsync: sharedPreferences,
        authenticationRepository: AuthenticationRepositoryImpl(
          dataSource: LocalAuthDatasourceImpl(
            authService: authService,
            sharedPreferences: sharedPreferences,
          ),
          mapper: UserMapper(),
        ),
      ),
      child: AuthGate(),
    ),
  );
}
