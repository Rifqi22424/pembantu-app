import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:prt/main.dart';
import 'package:prt/src/database/shared_preferences.dart';

class RegistPekerjaModel {
  final String baseUrl = '$serverPath/api/';

  Future<bool> registerFirstPage(String role) async {
    int? userId = await getIdFromSharedPreferences();
    final response = await http.put(
      Uri.parse('$baseUrl/profiles/step-1/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'name': role}),
    );

    if (response.statusCode == 200) {
      return true; // Registrasi berhasil
    } else {
      throw Exception('Gagal mendaftar'); // Registrasi gagal
    }
  }

  Future<bool> registerSecondPage(
    String namaLengkap,
    String alamatKtp,
    String kecamatanId,
    String selectedAgama,
    String alamatSekarang,
    String tanggalLahir,
    String jenisKelamin,
  ) async {
    final Map<String, dynamic> requestData = {
      'nama_lengkap': namaLengkap,
      'alamat_ktp': alamatKtp,
      'kecamatan_id': kecamatanId,
      'agama': selectedAgama,
      'alamat_sekarang': alamatSekarang,
      'tanggal_lahir': tanggalLahir,
      'jenis_kelamin': jenisKelamin,
    };

    int? userId = await getIdFromSharedPreferences();
    final response = await http.put(
      Uri.parse('$baseUrl/profiles/step-2/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.statusCode);
      throw Exception('Gagal mendaftar');
    }
  }

  Future<bool> registerThirdPage(
    String noKtp,
    String noTelp,
    String tinggiBadan,
    String beratBadan,
    String usia,
    String statusMenikah,
  ) async {
    final Map<String, dynamic> requestData = {
      'no_ktp': noKtp,
      'no_telp': noTelp,
      'tinggi_badan': tinggiBadan,
      'berat_badan': beratBadan,
      'usia': usia,
      'status_menikah': statusMenikah,
    };

    int? userId = await getIdFromSharedPreferences();
    final response = await http.put(
      Uri.parse('$baseUrl/profiles/step-3/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<bool> registerFourthPage(
    String temanNama,
    String temanAlamatKtp,
    String temanNoTelp,
    String temanAlamatSekarang,
  ) async {
    final Map<String, dynamic> requestData = {
      'teman_nama': temanNama,
      'teman_alamat_ktp': temanAlamatKtp,
      'teman_no_telp': temanNoTelp,
      'teman_alamat_sekarang': temanAlamatSekarang,
    };

    int? userId = await getIdFromSharedPreferences();
    final response = await http.put(
      Uri.parse('$baseUrl/profiles/step-4/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal mendaftar');
    }
  }

  Future<bool> registerFifthPage(
    String profesi,
    String deskripsi,
    String lamaPengalamanBekerja,
    String pendidikanTerakhir,
    String gaji,
    String skill,
  ) async {
    final Map<String, dynamic> requestData = {
      'profesi': profesi,
      'deskripsi': deskripsi,
      'lama_pengalaman_bekerja': lamaPengalamanBekerja,
      'pendidikan_terakhir': pendidikanTerakhir,
      'gaji': gaji,
      'skill': skill,
    };

    int? userId = await getIdFromSharedPreferences();
    final response = await http.put(
      Uri.parse('$baseUrl/profiles/step-5/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<bool> registerSixthPage(
    File selectedKTPimg,
    File selectedSKBIimg,
    File selectedHalfImg,
    File selectedFullImg,
    File selectedSertifImg,
  ) async {
    final dio = Dio();

    final formData = FormData.fromMap({
      'foto_ktp': await MultipartFile.fromFile(selectedKTPimg.path,
          filename: 'ktp_image.jpg', contentType: MediaType('image', 'jpeg')),
      'foto_skck': await MultipartFile.fromFile(selectedSKBIimg.path,
          filename: 'skck_image.jpg', contentType: MediaType('image', 'jpeg')),
      'foto_setengah_badan': await MultipartFile.fromFile(selectedHalfImg.path,
          filename: 'half_image.jpg', contentType: MediaType('image', 'jpeg')),
      'foto_satu_badan': await MultipartFile.fromFile(selectedFullImg.path,
          filename: 'full_image.jpg', contentType: MediaType('image', 'jpeg')),
      'foto_sertifikat': await MultipartFile.fromFile(selectedSertifImg.path,
          filename: 'sertifikat_image.jpg',
          contentType: MediaType('image', 'jpeg')),
    });

    try {
      int? userId = await getIdFromSharedPreferences();
      final response = await dio.post(
        '$baseUrl/profiles/step-6/$userId',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Image error');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
      throw Exception('Image error');
    }
  }
}
