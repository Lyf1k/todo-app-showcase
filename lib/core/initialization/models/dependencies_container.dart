import 'package:partfolio_app/core/service/auth_service.dart';
import 'package:partfolio_app/core/service/notification_service.dart';
import 'package:partfolio_app/feautures/auth/domain/repository/authentication_repository.dart';
import 'package:partfolio_app/feautures/tasks/data/model/tasks_model.dart';
import 'package:partfolio_app/feautures/tasks/domain/repository/tasks_repository.dart';
import 'package:partfolio_app/feautures/tasks/presentation/state/tasks_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
