import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchData {
  final String? baseUrl = 'http://192.168.1.3:8000/api';
  final String? authToken;
  final String? id;

  FetchData(this.authToken, this.id);

  Future<Map<String, dynamic>> fetchProvinsiData() async {  
    final response = await http.get(
      Uri.parse('$baseUrl/provinsi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer $authToken', // Tambahkan token Authorization ke header
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data;
    } else {
      throw Exception('Gagal mengambil data provinsi');
    }
  }

  Future<Map<String, dynamic>> fetchKotaData(String? selectedProvinsi) async {
    final response = await http.get(
      Uri.parse('$baseUrl/cities/${selectedProvinsi ?? ''}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer $authToken', // Tambahkan token Authorization ke header
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data;
    } else {
      throw Exception('Gagal mengambil data provinsi');
    }
  }

  Future<Map<String, dynamic>> fetchKecamatanData(String? selectedKota) async {
    final response = await http.get(
      Uri.parse('$baseUrl/districts/${selectedKota ?? ''}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer $authToken', // Tambahkan token Authorization ke header
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data;
    } else {
      throw Exception('Gagal mengambil data provinsi');
    }
  }

  Future<List<dynamic>> fetchSkillsData() async {
    final response = await http.get(
      Uri.parse('$baseUrl/skills'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer $authToken', // Tambahkan token Authorization ke header
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final value = data['data'];
      return value;
    } else {
      throw Exception('Gagal mengambil data skills');
    }
  }

  Future<List<dynamic>> fetchCategoriesData() async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer $authToken', // Tambahkan token Authorization ke header
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final value = data['data'];
      return value;
    } else {
      throw Exception('Gagal mengambil data skills');
    }
  }
}
