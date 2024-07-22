import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:prt/main.dart';
import 'package:prt/src/database/shared_preferences.dart';

class RegistPekerjaModel {
  Future<bool> registerFirstPage(String role) async {
    int? userId = await getIdFromSharedPreferences();
    print(userId);
    final response = await http.put(
      Uri.parse('$serverPath/api/profiles/step-1/${userId.toString()}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'name': role}),
    );

    if (response.statusCode == 200) {
      return true; // Registrasi berhasil
    } else {
      throw Exception(response.statusCode); // Registrasi gagal
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
      'alamat_sekarang': alamatSekarang,
      'agama': selectedAgama,
      'tanggal_lahir': tanggalLahir,
      'kecamatan_id': kecamatanId,
      'jenis_kelamin': jenisKelamin,
    };

    int? userId = await getIdFromSharedPreferences();
    print(
        "$userId, $namaLengkap, $alamatKtp, $alamatSekarang, $selectedAgama, $tanggalLahir, $kecamatanId, $jenisKelamin");
    final response = await http.put(
      Uri.parse('$serverPath/api/profiles/step-2/${userId.toString()}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      throw Exception(responseJson['message']);
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
      Uri.parse('$serverPath/api/profiles/step-3/${userId.toString()}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      throw Exception(responseJson['message']);
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
      Uri.parse('$serverPath/api/profiles/step-4/${userId.toString()}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      throw Exception(responseJson['message']);
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
    print(userId);
    final response = await http.put(
      Uri.parse('$serverPath/api/profiles/step-5/${userId.toString()}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('salah di step 4');
      print(
          '$userId, $profesi, $deskripsi, $lamaPengalamanBekerja, $pendidikanTerakhir, $gaji, $skill');
      var responseJson = jsonDecode(response.body);
      throw Exception(responseJson['message']);
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
      print(userId);
      final response = await dio.post(
        '$serverPath/api/profiles/step-6/${userId.toString()}',
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

  Future<bool> registersSixthPage(
    File selectedKTPimg,
    File selectedSKBIimg,
    File selectedHalfImg,
    File selectedFullImg,
    File selectedSertifImg,
  ) async {
    int? userId = await getIdFromSharedPreferences();
    print(userId);

    var uri = Uri.parse('$serverPath/api/profiles/step-6/${userId.toString()}');
    print('$serverPath/api/profiles/step-6/${userId.toString()}');
    var request = http.MultipartRequest('POST', uri);

    // Adding the KTP image
    var ktpStream = http.ByteStream(selectedKTPimg.openRead());
    var ktpLength = await selectedKTPimg.length();
    var ktpMimeType = lookupMimeType(selectedKTPimg.path);
    var ktpMultipartFile = http.MultipartFile(
      'foto_ktp',
      ktpStream,
      ktpLength,
      filename: basename(selectedKTPimg.path),
      contentType: MediaType.parse(ktpMimeType ?? 'image/jpeg'),
    );

    // Adding the SKBI image
    var skbiStream = http.ByteStream(selectedSKBIimg.openRead());
    var skbiLength = await selectedSKBIimg.length();
    var skbiMimeType = lookupMimeType(selectedSKBIimg.path);
    var skbiMultipartFile = http.MultipartFile(
      'foto_skck',
      skbiStream,
      skbiLength,
      filename: basename(selectedSKBIimg.path),
      contentType: MediaType.parse(skbiMimeType ?? 'image/jpeg'),
    );

    // Adding the Half Body image
    var halfStream = http.ByteStream(selectedHalfImg.openRead());
    var halfLength = await selectedHalfImg.length();
    var halfMimeType = lookupMimeType(selectedHalfImg.path);
    var halfMultipartFile = http.MultipartFile(
      'foto_setengah_badan',
      halfStream,
      halfLength,
      filename: basename(selectedHalfImg.path),
      contentType: MediaType.parse(halfMimeType ?? 'image/jpeg'),
    );

    // Adding the Full Body image
    var fullStream = http.ByteStream(selectedFullImg.openRead());
    var fullLength = await selectedFullImg.length();
    var fullMimeType = lookupMimeType(selectedFullImg.path);
    var fullMultipartFile = http.MultipartFile(
      'foto_satu_badan',
      fullStream,
      fullLength,
      filename: basename(selectedFullImg.path),
      contentType: MediaType.parse(fullMimeType ?? 'image/jpeg'),
    );

    // Adding the Sertifikat image
    var sertifStream = http.ByteStream(selectedSertifImg.openRead());
    var sertifLength = await selectedSertifImg.length();
    var sertifMimeType = lookupMimeType(selectedSertifImg.path);
    var sertifMultipartFile = http.MultipartFile(
      'foto_sertifikat',
      sertifStream,
      sertifLength,
      filename: basename(selectedSertifImg.path),
      contentType: MediaType.parse(sertifMimeType ?? 'image/jpeg'),
    );

    request.files.add(ktpMultipartFile);
    request.files.add(skbiMultipartFile);
    request.files.add(halfMultipartFile);
    request.files.add(fullMultipartFile);
    request.files.add(sertifMultipartFile);

    // Adding headers
    request.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
    });

    var response = await request.send();

    var responseData = await http.Response.fromStream(response);
    print('Response status: ${responseData.statusCode}');
    print('Response body: ${responseData.body}');

    if (responseData.statusCode == 200) {
      return true;
    } else {
      var responseJson = jsonDecode(responseData.body);
      throw Exception(responseJson['message']);
    }
  }

  Future<bool> updateProfileText(
    String name,
    String notelp,
    String alamat,
    String gaji,
  ) async {
    final Map<String, dynamic> requestData = {
      'nama_lengkap': name,
      'alamat_sekarang': alamat,
      'no_telp': notelp,
      'gaji': gaji.toString(),
    };

    int? userId = await getIdFromSharedPreferences();
    final response = await http.put(
      Uri.parse('$serverPath/api/profiles/update-profile/${userId.toString()}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      throw Exception(responseJson['message']);
    }
  }

  Future<bool> editProfilePencariText(
    String name,
    String notelp,
    String alamat,
  ) async {
    final Map<String, dynamic> requestData = {
      'nama_lengkap': name,
      'alamat_sekarang': alamat,
      'no_telp': notelp,
    };

    int? userId = await getIdFromSharedPreferences();
    final response = await http.put(
      Uri.parse('$serverPath/api/profiles/pencari/${userId.toString()}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      throw Exception(responseJson['message']);
    }
  }

  Future<bool> updateProfilePhoto(
    File selectedHalfImg,
  ) async {
    final dio = Dio();

    final formData = FormData.fromMap({
      'foto_setengah_badan': await MultipartFile.fromFile(selectedHalfImg.path,
          filename: 'half_image.jpg', contentType: MediaType('image', 'jpeg')),
    });

    try {
      int? userId = await getIdFromSharedPreferences();
      print(userId);
      final response = await dio.post(
        '$serverPath/api/profiles/update-photo-profile/${userId.toString()}',
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

  Future<bool> editProfilePencariPhoto(
    File selectedHalfImg,
  ) async {
    final dio = Dio();

    final formData = FormData.fromMap({
      'foto_setengah_badan': await MultipartFile.fromFile(selectedHalfImg.path,
          filename: 'half_image.jpg', contentType: MediaType('image', 'jpeg')),
    });

    try {
      int? userId = await getIdFromSharedPreferences();
      print(userId);
      final response = await dio.post(
        '$serverPath/api/profiles/update-photo-profile/${userId.toString()}',
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

  Future<bool> registerPencariText(
    String namaLengkap,
    String noKtp,
    String alamatSekarang,
    String noTelp,
    String usia,
    String statusMenikah,
  ) async {
    final Map<String, dynamic> requestData = {
      'nama_lengkap': namaLengkap,
      'no_ktp': noKtp,
      'alamat_sekarang': alamatSekarang,
      'no_telp': noTelp,
      'usia': usia,
      'status_menikah': statusMenikah,
    };

    int? userId = await getIdFromSharedPreferences();
    final response = await http.put(
      Uri.parse('$serverPath/api/profiles/update-pencari/${userId.toString()}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception(responseBody['message']);
    }
  }

  Future<bool> registerPencariPhoto(
    File selectedKTPimg,
    File selectedHalfImg,
  ) async {
    final dio = Dio();

    final formData = FormData.fromMap({
      'foto_ktp': await MultipartFile.fromFile(selectedKTPimg.path,
          filename: 'ktp_image.jpg', contentType: MediaType('image', 'jpeg')),
      'foto_setengah_badan': await MultipartFile.fromFile(selectedHalfImg.path,
          filename: 'half_image.jpg', contentType: MediaType('image', 'jpeg')),
    });

    int? userId = await getIdFromSharedPreferences();
    print(userId);
    final response = await dio.post(
      '$serverPath/api/profiles/update-photo-pencari/${userId.toString()}',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.statusMessage);
      print(response.data.toString());
      throw Exception(response.data.toString());
    }
  }

  Future<bool> registersPencariPhoto(
      File selectedKTPimg, File selectedHalfImg) async {
    int? userId = await getIdFromSharedPreferences();
    print(userId);

    var uri = Uri.parse(
        '$serverPath/api/profiles/update-photo-pencari/${userId.toString()}');
    print('$serverPath/api/profiles/update-photo-pencari/${userId.toString()}');
    var request = http.MultipartRequest('POST', uri);

    // Adding the KTP image
    var ktpStream = http.ByteStream(selectedKTPimg.openRead());
    var ktpLength = await selectedKTPimg.length();
    var ktpMimeType = lookupMimeType(selectedKTPimg.path);
    var ktpMultipartFile = http.MultipartFile(
      'foto_ktp',
      ktpStream,
      ktpLength,
      filename: basename(selectedKTPimg.path),
      contentType: MediaType.parse(ktpMimeType ?? 'image/jpeg'),
    );

    // Adding the Half Body image
    var halfStream = http.ByteStream(selectedHalfImg.openRead());
    var halfLength = await selectedHalfImg.length();
    var halfMimeType = lookupMimeType(selectedHalfImg.path);
    var halfMultipartFile = http.MultipartFile(
      'foto_setengah_badan',
      halfStream,
      halfLength,
      filename: basename(selectedHalfImg.path),
      contentType: MediaType.parse(halfMimeType ?? 'image/jpeg'),
    );

    request.files.add(ktpMultipartFile);
    request.files.add(halfMultipartFile);

    request.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });

    // Send the request
    var response = await request.send();

    // Parse the response
    var responseData = await http.Response.fromStream(response);
    print('Response status: ${responseData.statusCode}');
    print('Response body: ${responseData.body}');

    if (responseData.statusCode == 200) {
      return true;
    } else {
      var responseJson = jsonDecode(responseData.body);
      throw Exception(responseJson['message']);
    }
  }
}
