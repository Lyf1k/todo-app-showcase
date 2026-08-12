import '../entity/tasks.dart';

abstract interface class TasksRepository {
  Future<List<Tasks>> getTasks(int userId);
  Future<void> addTasks(Tasks task, int userId);
  Future<void> delTasks(int taskId, int userId);
  Future<void> delAllTasks(int userId);
  Future<void> editTasks(Tasks task, int userId);
}
