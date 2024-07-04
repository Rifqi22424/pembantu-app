import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveIdToSharedPreferences(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('user_id', id);
}

Future<int?> getIdFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('user_id');
}

Future<void> saveTokenToSharedPreferences(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
}

Future<String?> getTokenFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

Future<void> saveDeviceTokenToSharedPreferences(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('device_token', token);
}

Future<String?> getDeviceTokenFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('device_token');
}

Future<void> saveVcallNameToSharedPreferences(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('vcall_name', token);
}

Future<String?> getVcallNameFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
return prefs.getString('vcall_name');
}

Future<void> saveVcallTokenToSharedPreferences(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('vcall_token', token);
}

Future<String?> getVcallTokenFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('vcall_token');
}

Future<void> saveRoleToSharedPreferences(String role) async {
  print(role);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('role', role);
}

Future<String?> getRoleFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('role');
}
