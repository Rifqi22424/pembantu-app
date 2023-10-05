// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';
import 'package:prt/src/models/user_model.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = userList;

  List<User> get users => _users;

  void updateUserLikedStatus(int userId, bool isLiked) {
    final userIndex = _users.indexWhere((user) => user.id == userId);
    if (userIndex != -1) {
      _users[userIndex].isLiked = isLiked;
      notifyListeners();
    }
  }
}
