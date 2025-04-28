import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/todo.dart';

class ApiService {
  static const baseUrl = 'https://dummyjson.com';

  static Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User(id: data['id'], username: data['username'], token: data['accessToken']);
    } else {
      throw Exception('Login failed');
    }
  }

  

  static Future<void> addTodo(String token, String task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos/add'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: jsonEncode({'todo': task, 'completed': false}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add todo');
    }
  }

  static Future<void> updateTodo(String token, int id, bool completed) async {
    final response = await http.put(
      Uri.parse('$baseUrl/todos/$id'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: jsonEncode({'completed': completed}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }

  static Future<void> deleteTodo(String token, int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/todos/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
