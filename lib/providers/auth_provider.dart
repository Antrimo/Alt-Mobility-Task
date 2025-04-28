import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;

  bool get isAuthenticated => _user != null;
  User get user => _user!;

  Future<void> login(String username, String password) async {
    _user = await ApiService.login(username, password);
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
