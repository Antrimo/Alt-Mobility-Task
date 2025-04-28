import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<void> fetchTodos(int userId) async {
    final url = 'https://dummyjson.com/todos/user/$userId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> todoList = data['todos'];

      _todos = todoList.map((item) => Todo.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> addTodo(String title, int userId) async {
    final url = 'https://dummyjson.com/todos/add';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'todo': title,
        'completed': false,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      _todos.add(Todo.fromJson(data));
      notifyListeners();
    }
  }

  Future<void> updateTodoStatus(int id, bool completed) async {
    final url = 'https://dummyjson.com/todos/$id';
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'completed': completed,
      }),
    );

    if (response.statusCode == 200) {
      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        _todos[index].completed = completed;
        notifyListeners();
      }
    }
  }

  Future<void> deleteTodo(int id) async {
    final url = 'https://dummyjson.com/todos/$id';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      _todos.removeWhere((todo) => todo.id == id);
      notifyListeners();
    }
  }
}
