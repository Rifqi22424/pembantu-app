import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prt/src/models/transaction_model.dart';
import '../../main.dart';
import '../database/shared_preferences.dart';

class DigitalMoney {
  Future<bool> topup(int nominal, int bankId) async {
    String? userToken = await getTokenFromSharedPreferences();
    int? userId = await getIdFromSharedPreferences();
    print(userToken);

    final response = await http.post(
      Uri.parse('$serverPath/api/topup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $userToken',
      },
      body: jsonEncode(<String, String>{
        'nominal': nominal.toString(),
        'wallet_id': userId.toString(),
        'bank_id': bankId.toString(),
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      var responseJson = jsonDecode(response.body);
      throw Exception(responseJson['message']);
    }
  }

  Future<bool> withdraw(int nominal, int bankId) async {
    String? userToken = await getTokenFromSharedPreferences();
    print(userToken);

    final response = await http.post(
      Uri.parse('$serverPath/api/withdraw'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $userToken',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'nominal': nominal.toString(),
        'bank_id': bankId.toString(),
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      var responseJson = jsonDecode(response.body);
      print(responseJson);
      throw Exception(responseJson['data']);
    }
  }

  Future<bool> transfer(int nominal, int bankId, int receiverId) async {
    String? userToken = await getTokenFromSharedPreferences();
    print(userToken);

    final response = await http.post(
      Uri.parse('$serverPath/api/transfer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $userToken',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'nominal': nominal.toString(),
        'bank': bankId.toString(),
        'receiver_id': receiverId.toString(),
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      var responseJson = jsonDecode(response.body);
      print(responseJson);
      throw Exception(responseJson['data']);
    }
  }

  Future<List<Transaction>> fetchData() async {
    String? userToken = await getTokenFromSharedPreferences();
    final response = await http.get(
      Uri.parse('$serverPath/api/history-transaction'),
      headers: <String, String>{
        'Authorization': 'Bearer $userToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];

      List<Transaction> transactions = jsonData.map((data) {
        return Transaction.fromJson(Map<String, dynamic>.from(data));
      }).toList();

      return transactions.reversed.toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

Future<int> fetchOwnSaldo() async {
  String? userToken = await getTokenFromSharedPreferences();

  final response = await http.get(
    Uri.parse('$serverPath/api/cek-saldo'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8;',
      'Authorization': 'Bearer $userToken',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body)['data'];
    final int? nominal = data['nominal'];
    return nominal ?? 0;
  } else {
    throw Exception(
        'Failed to load saldo data with response status code ${response.statusCode}');
  }
}
