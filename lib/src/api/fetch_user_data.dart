import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prt/main.dart';

class UserProfile {
  final String email;
  final String phone;
  bool isLiked;
  final Map<String, dynamic> profile;
  final Map<String, dynamic> category;

  UserProfile({
    required this.email,
    required this.phone,
    required this.isLiked,
    required this.profile,
    required this.category,
  });
}

Future<List<UserProfile>> fetchUserProfiles() async {
  final response = await http
      .get(Uri.parse('$serverPath/api/profiles'), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8;',
    'Authorization':
        'Bearer 9|2R03rpTaSXZjAPiZxigTHUV0oVVeP4Xhgej3NAKH694990ee',
  });

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);

    if (data.containsKey('data')) {
      final List<dynamic> userDataList = data['data'];
      final List<UserProfile> profiles = userDataList
          .where((userData) => userData['category'] != null)
          .map((userData) {
        return UserProfile(
          email: userData['email'] ?? "",
          phone: userData['phone'] ?? "",
          isLiked: false,
          profile: userData['profile'] ?? {},
          category: userData['category'] ?? {},
        );
      }).toList();
      return profiles;
    } else {
      throw Exception('Data "data" tidak ditemukan dalam respons');
    }
  } else {
    throw Exception(response.statusCode);
  }
}
