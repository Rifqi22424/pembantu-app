import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prt/main.dart';
import 'package:prt/src/database/shared_preferences.dart';

class Auth {
  Future<int> register(String email, String phone, String password,
      String passwordConfirm) async {
    final response = await http.post(
      Uri.parse('$serverPath/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirm,
      }),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body)['data']['id'];
    } else {
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      throw Exception(responseJson['message']);
    }
  }

  Future<Map<String, dynamic>> login(String gmail, String password) async {
  final response = await http.post(
      Uri.parse('$serverPath/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'email': gmail,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final data = responseData['data'];
      return data;
    } else {
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      throw Exception(responseJson['data']);
    }
  }

  Future<bool> sendVerificationCode(String combinedCode) async {
    int? userId = await getIdFromSharedPreferences();
    print(userId);
    final Map<String, dynamic> payload = {
      'otp': combinedCode,
      'id': userId,
    };

    final response = await http.post(
      Uri.parse('$serverPath/api/verif-otp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final responseJson = jsonDecode(response.body);
      print(responseJson['data']);
      throw Exception(responseJson['data']);
    }
  }

  Future<bool> resendVerificationCode() async {
    int? userId = await getIdFromSharedPreferences();
    print(userId);
    final Map<String, dynamic> payload = {
      'id': userId,
    };

    final response = await http.post(
      Uri.parse(
          '$serverPath/api/refresh-otp'), // Ganti URL_API_ANDA dengan URL API sesuai kebutuhan Anda.
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<bool> saveToken(String token) async {
    int? userId = await getIdFromSharedPreferences();
    final response = await http.post(
        Uri.parse('$serverPath/api/device_token/${userId.toString()}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "device_token": token,
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
          'Gagal menyimpan token. Kode Status: ${response.statusCode}');
    }
  }

  Future<bool> forgotPassword(String gmail) async {
  final response = await http.post(
      Uri.parse('$serverPath/api/forgot-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'email': gmail,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      throw Exception(responseJson['data']);
    }
  }
}

class VideoCall {
  final String baseUrl = '$serverPath/api';

  Future<String> getToken(String name) async {
    final response = await http.post(Uri.parse('$baseUrl/agora'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "name": name,
        }));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String? token = responseData['data']['Token'];
      return token ?? '';
    } else {
      throw Exception(
          'Gagal mengambil token. Kode Status: ${response.statusCode}');
    }
  }
}
