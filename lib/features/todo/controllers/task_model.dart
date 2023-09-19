class TaskModel {
  TaskModel(
      {this.id,
      this.title,
      this.description,
      this.isCompleted = false,
       this.date,
       this.startTime,
       this.endTime,
      this.remind = false,
      this.repeat = true
      });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int?,
      title: map['title'] as String?,
      description: map['description'] as String?,
      isCompleted: (map['isCompleted'] as num) == 1,
      date: DateTime.parse(map['date'] as String),
      startTime: DateTime.parse(map['startTime'] as String),
      endTime: DateTime.parse(map['endTime'] as String),
      remind: (map['remind'] as num) == 1,
      repeat: map['repeat'] as num == 1,
    );
  }
  int? id;
  String? title;
  String? description;
  bool isCompleted;
  DateTime? date;
  DateTime? startTime;
  DateTime? endTime;
  bool remind;
  bool repeat;

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'isCompleted': isCompleted ? 1 : 0,
        'date': date.toString(),
        'startTime': startTime.toString(),
        'endTime': endTime.toString(),
        'remind': remind ? 1 : 0,
        'repeat': repeat ? 1 :0
      };
}
