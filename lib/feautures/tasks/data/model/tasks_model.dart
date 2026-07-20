import '../../domain/entity/tasks.dart';

class TasksModel extends Tasks {
  TasksModel({required super.id, required super.text, super.dateTime});

  factory TasksModel.fromJson(Map<String, dynamic> e) {
    return TasksModel(
      id: e['id'],
      text: e['text'],
      dateTime: e['date_time'] ?? null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'date_time': "${dateTime.toString()}",
  };
}
