import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/auth/domain/repository/authentication_repository.dart';
import '../../../features/tasks/domain/repository/tasks_repository.dart';
import '../../service/notification_service.dart';

class DependenciesContainer {
  final SharedPreferencesAsync sharedPreferencesAsync;
  final AuthenticationRepository authenticationRepository;
  final TasksRepository tasksRepository;
  final NotificationService notificationService;

  DependenciesContainer({
    required this.notificationService,
    required this.sharedPreferencesAsync,
    required this.authenticationRepository,
    required this.tasksRepository,
  });
}
