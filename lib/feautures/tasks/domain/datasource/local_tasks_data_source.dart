import 'package:partfolio_app/feautures/tasks/data/model/tasks_model.dart';

abstract interface class LocalTasksDataSource {
  Future<List<TasksModel>> getTasks(int userId);
  Future<void> addTasks(TasksModel task, int userId);
  Future<void> delTasks(int taskId, int userId);
  Future<void> allDelTasks(int userId);
  Future<void> editTasks(TasksModel task, int userId);
}
