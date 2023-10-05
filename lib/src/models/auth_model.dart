import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth {
  final String baseUrl = 'http://192.168.1.3:8000/api';

  Future<bool> register(String email, String phone, String password,
      String passwordConfirm) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
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
      return true; // Registrasi berhasil
    } else {
      throw Exception('Gagal mendaftar'); // Registrasi gagal
    }
  }

  Future<bool> login(String gmail, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': gmail,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return true; // Login berhasil
    } else {
      throw Exception('Gagal login'); // Login gagal
    }
  }
}
