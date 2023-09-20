import 'dart:convert';

class TodoResponse {
  List<Todo> todo;

  TodoResponse({
    required this.todo,
  });

  factory TodoResponse.fromJson(Map<String, dynamic> json) => TodoResponse(
        todo: List<Todo>.from(json["data"].map((x) => Todo.fromJson(x))),
      );

  static Map<String, dynamic> toMap(TodoResponse todoResponse) => {
        'data': todoResponse.todo,
      };
}

class Todo {
  String id;
  String todoText;
  String datetime;
  bool isDone;
  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
    required this.datetime,
    
  });
  static List<Todo> todoList() {
    return [];
  }

  factory Todo.fromJson(Map<String, dynamic> jsonData) {
    return Todo(
        id: jsonData['todoid'] ?? "0",
        todoText: jsonData['todo_data'] ?? '-',
        datetime: jsonData['todo_datetime'] ?? '${DateTime.now()}',
        isDone: jsonData['ischeck'] ?? false);
  }

  static Map<String, dynamic> toMap(Todo todo) => {
        'todoid': todo.id,
        'todo_data': todo.todoText,
        'todo_datetime': todo.datetime,
        'ischeck': todo.isDone,
      };

  static String encode(List<Todo> todos) => json.encode(
        todos.map<Map<String, dynamic>>((todo) => Todo.toMap(todo)).toList(),
      );

  static List<Todo> decode(String todos) =>
      (json.decode(todos) as List<dynamic>)
          .map<Todo>((item) => Todo.fromJson(item))
          .toList();
}
