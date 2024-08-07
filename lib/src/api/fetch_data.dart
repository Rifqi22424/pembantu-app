import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prt/main.dart';
import 'package:prt/src/database/shared_preferences.dart';

class FetchData {
  final String? baseUrl = '$serverPath/api';
  final String? id;

  FetchData(this.id);

  Future<Map<String, dynamic>> fetchProvinsiData() async {
    final response = await http.get(
      Uri.parse('$baseUrl/provinsi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
      Uri.parse('$serverPath/api/skills'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer 2|HwLUDE60MVnRLH58SxfbxGZgeinTWDgZDLZeR5v39bf325bd',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final value = data['data'];
      return value;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<dynamic>> fetchCategoriesData() async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer 2|HwLUDE60MVnRLH58SxfbxGZgeinTWDgZDLZeR5v39bf325bd',
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

  Future<Map<String, dynamic>> createTokenVideocall() async {
    String? userToken = await getTokenFromSharedPreferences();
    print(userToken);
    final response =
        await http.get(Uri.parse('$baseUrl/agora/'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $userToken',
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final value = data['data'];
      return value;
    } else {
      throw Exception('gagal mengambil token');
    }
  }
}
