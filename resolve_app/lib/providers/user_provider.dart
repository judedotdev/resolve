// user_provider.dart
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _userName = '';
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phone = '';

  String get userName => _userName;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get phone => _phone;

  void setUserInfo(String userName, String firstName, String lastName,
      String email, String phone) {
    _userName = userName;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _phone = phone;
    notifyListeners();
  }
}
