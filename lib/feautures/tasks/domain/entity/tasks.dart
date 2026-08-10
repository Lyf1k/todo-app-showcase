class Tasks {
  final int id;
  final String text;
  final DateTime? dateTime;
  final bool isDone;

  Tasks({required this.id, required this.text, this.dateTime, required this.isDone});

  Tasks copyWith({int? id, String? text, DateTime? dateTime, bool? isDone}) {
    return Tasks(id: id ?? this.id, text: text ?? this.text, dateTime: dateTime ?? this.dateTime, isDone: isDone ?? this.isDone);
  }
}
