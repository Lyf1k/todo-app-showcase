import '../../domain/entity/tasks.dart';
import '../model/tasks_model.dart';

class TasksMapper {
  Tasks toEntity(TasksModel task) {
    return Tasks(id: task.id, text: task.text, dateTime: task.dateTime, isDone: task.isDone);
  }

  TasksModel toModel(Tasks task) {
    return TasksModel(id: task.id, text: task.text, dateTime: task.dateTime, isDone: task.isDone);
  }
}
