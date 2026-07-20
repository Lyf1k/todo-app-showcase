import 'dart:async';

import 'package:flutter/material.dart';
import 'package:partfolio_app/feautures/tasks/domain/entity/tasks.dart';
import 'package:partfolio_app/feautures/tasks/domain/repository/tasks_repository.dart';
import 'package:rxdart/subjects.dart';

class TasksController extends ChangeNotifier {
  final TasksRepository taskRepository;
  final int userId;
  TasksController({required this.taskRepository, required this.userId}) {
    loadData();
  }

  BehaviorSubject<List<Tasks>?> tasksStream = BehaviorSubject();
  List<Tasks> taskList = [];
  bool _isLoading = true;
  int? _editingIndex;

  bool get isLoading => _isLoading;
  int? get editingIndex => _editingIndex;
  bool get isEditing => editingIndex != null;

  @override
  String toString() => 'TasksController';

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 3000));
    taskList = await taskRepository.getTasks(userId);
    tasksStream.add(taskList);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addItem(String data, DateTime? todoDateTime) async {
    final newTask = Tasks(
      id: DateTime.now().microsecondsSinceEpoch,
      text: data,
      dateTime: todoDateTime == null ? null : "${todoDateTime}",
    );
    await taskRepository.addTasks(newTask, userId);
    await loadData();
    notifyListeners();
  }

  Future<void> editTask(int taskId, String newTitle, DateTime? dateTime) async {
    try {
      await taskRepository.editTasks(newTitle, taskId, userId);
      taskList = taskList.map((task) {
        if (task.id == taskId) {
          return Tasks(id: taskId, text: newTitle);
        } else {
          return task;
        }
      }).toList();
      tasksStream.add(taskList);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> delItem(int taskId) async {
    try {
      await taskRepository.delTasks(taskId, userId);
      await loadData();
    } catch (e) {
      print(e);
    }
  }

  Future<void> delAllItems() async {
    try {
      await taskRepository.delAllTasks(userId);
      // tasksStream.sink.add([]);
      await loadData();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (!tasksStream.isClosed) {
      tasksStream.close();
    }
    super.dispose();
  }
}
