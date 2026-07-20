import 'package:partfolio_app/feautures/tasks/data/model/tasks_model.dart';
import 'package:partfolio_app/feautures/tasks/domain/entity/tasks.dart';

abstract interface class TasksRepository {
  Future<List<Tasks>> getTasks(int userId);
  Future<void> addTasks(Tasks task, int userId);
  Future<void> delTasks(int taskId, int userId);
  Future<void> delAllTasks(int userId);
  Future<void> editTasks(String newTitle, int tasksId, int userId);
}
