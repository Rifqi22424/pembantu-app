import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prt/main.dart';
import 'package:prt/src/database/shared_preferences.dart';

class FirebaseNotifAPI {
  Future<bool> putToken(String deviceToken) async {
    int? userId = await getIdFromSharedPreferences();
    print(userId);
    final String stringId = userId.toString();

    final response = await http.post(
      Uri.parse('$serverPath/api/device-token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'id': stringId, 'device_token': deviceToken}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print("cek");
      print(stringId);
      print(deviceToken);
      print('Error notif');
      throw Exception(response.statusCode); // Login gagal
    }
  }

  Future<bool> sendNotification(
      String to, String from, String channelName, String token) async {
    const url = 'https://fcm.googleapis.com/fcm/send';
    const firebaseToken =
        'AAAAK4GnvJ4:APA91bFzNxsJvndbe0ZS1Rl4shZC9fcwMR-mz4U-L88xnVZyWTz0nmZEFP5wx03u-Uh0DJNgKVtdSzOZQxSfkvTUQtyPct1eOeoPun8Ayd45OGih111fO9VEMVQtP2DkIKh4DjPjznV7';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $firebaseToken'
    };

    final body = jsonEncode({
      "to": to,
      "notification": {"body": "Panggilan interview masuk", "title": from},
      "data": {"channel": channelName, "token": token}
    });

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('gagal mnegirim data ${response.body}');
    }
  }
}
