import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveIdToSharedPreferences(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('user_id', id);
}

Future<int?> getIdFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('user_id');
}
