


class Task {
  List<Task> tasks;
  String note;
  DateTime timeToComplete;
  bool competed;
  String repeats;
  DateTime deadLinde;
  List<DateTime> reminders;
  int taskId;
  String title;  

  Task(this.title, this.competed, this.taskId, this.note);

  factory Task.fromJson(Map<String, dynamic> parsedJson) {
    return Task(
      parsedJson['title'],
      parsedJson['completed'],
      parsedJson['id'],
      parsedJson['note'],
    );
  }

}
