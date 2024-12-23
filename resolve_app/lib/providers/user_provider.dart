import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _userName = 'John Doe';

  String get userName => _userName;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }
}
