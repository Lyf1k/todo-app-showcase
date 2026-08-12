import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/datasource/local_tasks_data_source.dart';
import '../model/tasks_model.dart';

class LocalTasksDataSourceImpl implements LocalTasksDataSource {
  final SharedPreferencesAsync sharedPreferences;

  LocalTasksDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> addTasks(TasksModel taskModel, int userId) async {
    final taskKey = "task_key_$userId";
    try {
      final getTasks = await sharedPreferences.getStringList(taskKey) ?? [];
      final task = json.encode(taskModel.toJson());
      getTasks.add(task);
      await sharedPreferences.setStringList(taskKey, getTasks);
    } catch (e) {
      throw Exception("Error durring add new Task: $e");
    }
  }

  @override
  Future<void> allDelTasks(int userId) async {
    final taskKey = "task_key_$userId";
    try {
      await sharedPreferences.remove(taskKey);
    } catch (e) {
      throw Exception("Error during deleting all tasks");
    }
  }

  @override
  Future<void> delTasks(int taskId, int userId) async {
    final taskKey = "task_key_$userId";
    try {
      final getTasks = await sharedPreferences.getStringList(taskKey);
      if (getTasks == null) return;
      final model = getTasks
          .map((e) => TasksModel.fromJson(jsonDecode(e)))
          .toList();
      model.removeWhere((e) => e.id == taskId);
      final result = model.map((e) => jsonEncode(e.toJson())).toList();
      await sharedPreferences.setStringList(taskKey, result);
    } catch (e) {
      throw Exception("Error during deleting task $taskId");
    }
  }

  @override
  Future<void> editTasks(TasksModel task, int userId) async {
    final taskKey = "task_key_$userId";
    try {
      final getTasks = await sharedPreferences.getStringList(taskKey);
      if (getTasks == null) return;
      final model = getTasks
          .map((e) => TasksModel.fromJson(jsonDecode(e)))
          .toList();
      final indexItem = model.indexWhere((e) => e.id == task.id);
      if (indexItem == -1) return;

      final old = model[indexItem];
      final result = TasksModel(
        id: old.id,
        text: task.text,
        dateTime: DateTime.now(),
        isDone: task.isDone,
      );
      model[indexItem] = result;
      final newList = model.map((e) => jsonEncode(e.toJson())).toList();
      await sharedPreferences.setStringList(taskKey, newList);
    } catch (e) {
      throw Exception("Error during editing task ${task.id}");
    }
  }

  @override
  Future<List<TasksModel>> getTasks(int userId) async {
    final taskKet = "task_key_$userId";
    try {
      final getTasks = await sharedPreferences.getStringList(taskKet) ?? [];
      final result = getTasks
          .map((e) => TasksModel.fromJson((jsonDecode(e))))
          .toList();
      return result;
    } catch (e) {
      throw Exception("Error durring getting tasks: $e");
    }
  }
}
