import 'dart:async';

import 'package:flutter/material.dart';
import 'package:partfolio_app/core/service/notification_service.dart';
import 'package:partfolio_app/feautures/tasks/domain/entity/tasks.dart';
import 'package:partfolio_app/feautures/tasks/domain/repository/tasks_repository.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart' as tz;

class TasksController extends ChangeNotifier {
  final TasksRepository taskRepository;
  final int userId;
  final NotificationService notificationService;
  TasksController({
    required this.taskRepository,
    required this.userId,
    required this.notificationService,
  }) {
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
    await Future.delayed(Duration(milliseconds: 500));
    taskList = await taskRepository.getTasks(userId);
    tasksStream.add(taskList);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleDoneTask(Tasks task) async {
    final updateTask = task.copyWith(isDone: !task.isDone);
    final oldTaskId = taskList.indexWhere((element) => element.id == task.id);
    final oldTask = taskList[oldTaskId];
    print(oldTaskId);

    if (oldTaskId == -1) return;

    taskList[oldTaskId] = updateTask;
    print(
      "old task status:${task.isDone} ---> New task status:${updateTask.isDone}",
    );
    tasksStream.add(taskList);
    notifyListeners();
    try {
      if (updateTask.isDone) {
        await notificationService.cancel(updateTask.id);
      }

      await taskRepository.editTasks(updateTask, userId);
    } catch (e) {
      taskList[oldTaskId] = oldTask;
      tasksStream.add(taskList);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addItem(Tasks task, {DateTime? todoNotificationTime}) async {
    // final newTask = Tasks(
    //   id: DateTime.now().microsecondsSinceEpoch,
    //   text: task.text,
    //   dateTime: task.dateTime, isDone: false,
    // );
    await taskRepository.addTasks(task, userId);
    print(task);
    await loadData();
    if (task.dateTime != null) {
      await notificationService.createSheduleNotification(
        taskId: task.id,
        importance: true,
        tickerText: "Create shedule",
        todoDateTime: tz.TZDateTime.from(todoNotificationTime!, tz.local),
        title: task.text,
      );
    }
    notifyListeners();
  }

  Future<void> editTask(Tasks taskToUpdate) async {
    try {
      await taskRepository.editTasks(taskToUpdate, userId);
      taskList = taskList.map((task) {
        if (task.id == taskToUpdate.id) {
          return Tasks(
            id: taskToUpdate.id,
            text: taskToUpdate.text,
            isDone: taskToUpdate.isDone,
          );
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
    print("TaskController disposed");
    if (tasksStream.isClosed) return;
    tasksStream.add(null);
    super.dispose();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   if (!tasksStream.isClosed) {
  //     tasksStream.close();
  //   }
  //   super.dispose();
  // }
}
