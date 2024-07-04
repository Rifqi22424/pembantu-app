import 'dart:convert';

import '../../main.dart';
import 'package:http/http.dart' as http;

import '../database/shared_preferences.dart';

class LikeApi {
  Future<bool> likeUser(int id) async {
    String? userToken = await getTokenFromSharedPreferences();
    final response = await http.post(Uri.parse('$serverPath/api/like'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $userToken',
        },
        body: jsonEncode(<String, String>{
          "receiver_liked_id": id.toString(),
        }));

    if (response.statusCode == 200) {
      print('masuk like');
      return true;
    } else {
      throw Exception(
          'Gagal menyimpan token. Kode Status: ${response.statusCode}');
    }
  }
}
