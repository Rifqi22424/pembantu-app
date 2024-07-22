import 'dart:convert';
import 'package:prt/main.dart';
import 'package:prt/src/database/shared_preferences.dart';
import 'package:prt/src/models/announcement_model.dart';
import 'package:http/http.dart' as http;

class AnnouncementService {
  final String baseUrl = "$serverPath/api/notification";

  Future<List<Announcement>> fetchAnnouncements() async {
    String? token = await getTokenFromSharedPreferences();
    print(token);

    final response = await http.get(
      Uri.parse(baseUrl), 
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['data'];
      return body.map((json) => Announcement.getAllFromJson(json)).toList();
    } else {
      throw Exception(response.body);
    }
  }

  Future<Announcement> fetchAnnouncementDetail(int id) async {
    String? token = await getTokenFromSharedPreferences();

    final response = await http.get(
      Uri.parse("$baseUrl/$id"),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return Announcement.getDetailFromJson(json.decode(response.body)['data']);
    } else {
      throw Exception(response.body);
    }
  }
}
