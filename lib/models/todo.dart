class Todo {
  final int id;
  final String title;
  bool completed;
  final int userId;

  Todo({
    required this.id,
    required this.title,
    required this.completed,
    required this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todo': title,
      'completed': completed,
      'userId': userId,
    };
  }
}
