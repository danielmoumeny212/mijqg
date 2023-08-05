import "package:flutter/material.dart" show ChangeNotifier;

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User _user = User.empty();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}