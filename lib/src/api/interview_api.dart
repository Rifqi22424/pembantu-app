import 'dart:convert';

import 'package:prt/main.dart';
import 'package:prt/src/database/shared_preferences.dart';
import 'package:prt/src/models/date_model.dart';
import 'package:prt/src/models/time_interview.dart';
import '../models/interview_model.dart';

import 'package:http/http.dart' as http;

import '../models/schedules_model.dart';

class InterviewApi {
  String url = "$serverPath/api";

  Future<bool> createCalendarSchedule(
      int id, InterviewFree date, String time) async {
    String? userToken = await getTokenFromSharedPreferences();

    final response = await http.post(
      Uri.parse("$url/create-calendar"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        'Authorization': 'Bearer $userToken',
      },
      body: jsonEncode({
        'date': '${DateTime.now().year}-${date.monthInt}-${date.day}',
        'time': time,
        'pekerja_id': id.toString(),
      }),
    );

    if (response.statusCode == 200) {
      print('${DateTime.now().year}-${date.monthInt}-${date.day}');
      print(time);
      print(id.toString());
      print('calendar berhasil');
      final responseData = json.decode(response.body);
      final data = responseData['data']['id'];

      final responseSchedule = await http.post(
        Uri.parse("$url/schedules"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'Authorization': 'Bearer $userToken',
        },
        body: jsonEncode({
          'calendar_id': data,
        }),
      );

      if (responseSchedule.statusCode == 200) {
        print(data);
        print('schedule berhasil');
        return true;
      } else {
        print('gagal di schedule');
        throw Exception(
            'Failed to add schedule ${responseSchedule.statusCode}');
      }
    } else {
      print('gagal di create calendar');
      throw Exception('Failed to create calendar ${response.statusCode}');
    }
  }

  Future<bool> createCostumCalendarSchedule(int id, Date interviewDate) async {
    String? userToken = await getTokenFromSharedPreferences();

    final response = await http.post(
      Uri.parse("$url/create-calendar"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        'Authorization': 'Bearer $userToken',
      },
      body: jsonEncode({
        'date':
            '${interviewDate.year.toString()}-${interviewDate.month.toString()}-${interviewDate.day.toString()}',
        'time':
            '${interviewDate.hour.toString()}:${interviewDate.minute.toString()}',
        'pekerja_id': id.toString(),
      }),
    );

    if (response.statusCode == 200) {
      print(
          '${interviewDate.year.toString()}-${interviewDate.month.toString()}-${interviewDate.day.toString()}');
      print(
          '${interviewDate.hour.toString()}:${interviewDate.minute.toString()}');
      print(id.toString());
      print('calendar berhasil');
      final responseData = json.decode(response.body);
      final data = responseData['data']['id'];

      final responseSchedule = await http.post(
        Uri.parse("$url/schedules"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'Authorization': 'Bearer $userToken',
        },
        body: jsonEncode({
          'calendar_id': data,
        }),
      );

      if (responseSchedule.statusCode == 200) {
        print(data);
        print('schedule berhasil');
        return true;
      } else {
        print('gagal di schedule');
        throw Exception(
            'Failed to add schedule ${responseSchedule.statusCode}');
      }
    } else {
      print('gagal di create calendar');
      throw Exception('Failed to create calendar ${response.statusCode}');
    }
  }

  Future<List<Interview>> fetchInterviews(String type) async {
    String? userToken = await getTokenFromSharedPreferences();

    final response = await http.post(
      Uri.parse("$url/filter"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $userToken',
      },
      body: jsonEncode(<String, String>{'status': type}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      final List<dynamic> data = jsonResponse['data'];

      List<Interview> interviews = data.map((json) {
        return Interview.fromJson(json);
      }).toList();

      return interviews;
    } else {
      throw Exception(
          'Failed to load interviews with status code ${response.statusCode}');
    }
  }

  // Future<List<Schedules>> fetchSchedules(String type) async {
  //   String? userToken = await getTokenFromSharedPreferences();

  //   final response = await http.post(
  //     Uri.parse("$url/filter"),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Bearer $userToken',
  //     },
  //     body: jsonEncode(<String, String>{'status': type}),
  //   );

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> jsonResponse = json.decode(response.body);

  //     final List<dynamic> data = jsonResponse['data'];

  //     List<Schedules> schedules = data.map((json) {
  //       return Schedules.fromJson(json);
  //     }).toList();

  //     return schedules;
  //   } else {
  //     throw Exception(
  //         'Failed to load interviews with status code ${response.statusCode}');
  //   }
  // }

  Future<List<Schedules>> fetchSchedules(String type) async {
    String? userToken = await getTokenFromSharedPreferences();

    final response = await http.post(
      Uri.parse("$url/filter"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $userToken',
      },
      body: jsonEncode(<String, String>{'status': type}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['data'];

      List<Schedules> schedules = data.map((json) {
        return Schedules.fromJson(json);
      }).toList();

      return schedules;
    } else {
      throw Exception(
          'Failed to load interviews with status code ${response.statusCode}');
    }
  }

  Future<bool> updateStatusInterview(
      bool isAccept, String calendarId, String scheduleId) async {
    String? userToken = await getTokenFromSharedPreferences();

    final response = await http.post(
      Uri.parse("$url/status"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $userToken',
      },
      body: jsonEncode({
        'status': isAccept ? "upcoming" : "reject",
        'calendar_id': calendarId,
        'schedule_id': scheduleId,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.statusCode);
      throw Exception('Failed to update status ${response.statusCode}');
    }
  }
}
