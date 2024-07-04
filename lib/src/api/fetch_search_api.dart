import 'dart:convert';
import 'package:prt/main.dart';
import 'fetch_user_data.dart';
import 'package:http/http.dart' as http;    

Future<List<UserProfile>> fetchSearchResultsFromAPI(String searchText) async {
  final apiUrl = '$serverPath/api/search';

  final response =
      await http.post(Uri.parse(apiUrl), body: {'search': searchText});

  if (response.statusCode == 200) {
    final List<UserProfile> searchResults = parseSearchResults(response.body);
    return searchResults;
  } else {
    throw Exception('Failed to load search results');
  }
}

List<UserProfile> parseSearchResults(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<UserProfile>((json) => UserProfile.fromJson(json)).toList();
}
