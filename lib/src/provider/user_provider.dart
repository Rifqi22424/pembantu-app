// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';
import 'package:prt/src/api/fetch_user_data.dart';

// import yang diperlukan

class UserProvider with ChangeNotifier {

  late List<UserProfile?> _users = [];

  List<UserProfile?> get users => _users;

  Future<void> fetchUsersFromApi() async {
    try {
      _users = await fetchUserProfiles();
      notifyListeners();
    } catch (error) {
      print('Terjadi kesalahan: $error');
      rethrow;
    }
  }

  void updateUserLikedStatus(int userId, bool isLiked) {
    final userIndex =
        _users.indexWhere((user) => user!.profile["id"] == userId);
    if (userIndex != -1) {
      _users[userIndex]!.isLiked = isLiked;
      notifyListeners();
    }
  }
}
