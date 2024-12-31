import 'package:flutter/material.dart';
import 'package:plane_pal/models/user/user.dart';

class UserNotifier extends ChangeNotifier {
  User? user;

  UserNotifier() : user = null;

  void logOut() {
    user = null;
    notifyListeners();
  }

  void login(String id, String name) {
    user = User(name: name, id: id);
    notifyListeners();
  }
}
