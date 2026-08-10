import '../../domain/entity/tasks.dart';

class TasksModel extends Tasks {
  TasksModel({required super.id, required super.text, super.dateTime, required super.isDone});

  factory TasksModel.fromJson(Map<String, dynamic> e) {
    return TasksModel(
      id: e['id'],
      text: e['text'],
      dateTime:(e['date_time'] != null || e['date_time'] == 'null') ? DateTime.parse(e['date_time'] as String) : null,
      isDone: e['is_done'] ?? false
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'date_time': dateTime?.toIso8601String(),
    'is_done': isDone
  };
}
