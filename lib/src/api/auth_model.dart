import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prt/main.dart';
import 'package:prt/src/database/shared_preferences.dart';

class Auth {
  Future<int> register(String email, String phone, String password,
      String passwordConfirm) async {
    final response = await http.post(
      Uri.parse('$serverPath/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirm,
      }),
    );

    if (response.statusCode == 200) {
      final id = jsonDecode(response.body)['data']?['id'] as int?;
      if (id != null) {
        return id;
      } else {
        return -1;
      }
    } else {
      throw Exception(response.statusCode); // Registrasi gagal
    }
  }

  Future<String> login(String gmail, String password) async {
    final response = await http.post(
      Uri.parse('$serverPath/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': gmail,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData['data']['token'];
      return token;
    } else {
      throw Exception('Gagal login'); // Login gagal
    }
  }

  Future<bool> sendVerificationCode(List<String> verificationCode) async {
    int? userId = await getIdFromSharedPreferences();
    final Map<String, dynamic> payload = {
      'verificationCode': verificationCode,
      'id': userId,
    };

    final response = await http.post(
      Uri.parse(
          '$serverPath/api/verif-otp'), // Ganti URL_API_ANDA dengan URL API sesuai kebutuhan Anda.
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Ada yang salah dalam verifikasi');
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
      return token ??
          ''; // Mengembalikan token atau string kosong jika tidak ditemukan
    } else {
      throw Exception(
          'Gagal mengambil token. Kode Status: ${response.statusCode}');
    }
  }
}
