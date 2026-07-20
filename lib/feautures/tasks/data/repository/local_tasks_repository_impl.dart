import 'package:partfolio_app/feautures/tasks/data/mapper/tasks_mapper.dart';
import 'package:partfolio_app/feautures/tasks/domain/datasource/local_tasks_data_source.dart';
import 'package:partfolio_app/feautures/tasks/domain/entity/tasks.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repository/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final LocalTasksDataSource dataSource;
  final TasksMapper tasksMapper;

  TasksRepositoryImpl({required this.dataSource, required this.tasksMapper});

  @override
  Future<void> addTasks(Tasks task, int userId) async {
    try {
      await dataSource.addTasks(tasksMapper.toModel(task), userId);
    } catch (e) {
      print("Error during tasks repository addTask: $e");
      throw Exception(e);
    }
  }

  @override
  Future<void> delAllTasks(int userId) async {
    try {
      await dataSource.allDelTasks(userId);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> delTasks(int taskId, int userId) async {
    try {
      await dataSource.delTasks(taskId, userId);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> editTasks(String newTitle, int tasksId, int userId) async {
    try {
      await dataSource.editTasks(newTitle, tasksId, userId);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Tasks>> getTasks(int userId) async {
    try {
      final tasks = await dataSource.getTasks(userId);
      return tasks;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
