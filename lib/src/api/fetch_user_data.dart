import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prt/main.dart';
import 'package:prt/src/database/database_cache.dart';
import 'package:prt/src/database/shared_preferences.dart';

class UserProfile {
  final int id;
  final String email;
  final String phone;
  final String devicetoken;
  bool isLiked;
  final Map<String, dynamic> profile;
  final Map<String, dynamic> category;

  UserProfile({
    required this.id,
    required this.email,
    required this.phone,
    required this.devicetoken,
    required this.isLiked,
    required this.profile,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'devicetoken': devicetoken,
      'isLiked': isLiked ? 1 : 0,
      'profile': jsonEncode(profile),
      'category': jsonEncode(category),
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as int,
      email: json['email'] as String,
      phone: json['phone'] as String,
      devicetoken: json['device_token'] ?? "",
      isLiked: json['liked'] == 1 ? true : false,
      profile: json['profile'] as Map<String, dynamic>,
      category: json['category'] as Map<String, dynamic>,
    );
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'],
      email: map['email'],
      phone: map['phone'],
      devicetoken: map['devicetoken'],
      isLiked: map['isLiked'] == 1,
      profile: map['profile'],
      category: map['category'],
    );
  }
}

Future<List<UserProfile>> fetchUserProfiles() async {
  String? userToken = await getTokenFromSharedPreferences();
  print(userToken);

  final response = await http.get(
    Uri.parse('$serverPath/api/profiles'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8;',
      'Authorization': 'Bearer $userToken',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);

    if (data.containsKey('data')) {
      final List<dynamic> userDataList = data['data'];
      final List<UserProfile> profiles = userDataList
          .where((userData) => userData['category'] != null)
          .map((userData) {
        return UserProfile(
          id: userData['id'] ?? "",
          email: userData['email'] ?? "",
          phone: userData['phone'] ?? "",
          devicetoken: userData['device_token'] ?? "",
          isLiked: userData['liked'] == 1 ? true : false,
          profile: userData['profile'] ?? {},
          category: userData['category'] ?? {},
        );
      }).toList();

      final cacheDB = CacheDatabase();
      await cacheDB.insertCacheData(profiles);

      return profiles;
    } else {
      throw Exception('Data "data" tidak ditemukan dalam respons');
    }
  } else {
    throw Exception(response.statusCode);
  }
}

Future<UserProfile> fetchUserProfile() async {
  String? userToken = await getTokenFromSharedPreferences();
  print(userToken);

  final response = await http.get(
    Uri.parse('$serverPath/api/profile'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8;',
      'Authorization': 'Bearer $userToken',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> userData = jsonDecode(response.body)['data'];
    print(userData);
    return UserProfile.fromJson({
      'id': userData['id'] ?? "",
      'email': userData['email'] ?? "",
      'phone': userData['phone'] ?? "",
      'devicetoken': userData['device_token'] ?? "",
      'isLiked': false,
      'profile': Map<String, dynamic>.from(userData['profile'] ?? {}),
      'category': Map<String, dynamic>.from(userData['category'] ?? {}),
    });
  } else {
    throw Exception('HTTP request failed with status: ${response.statusCode}');
  }
}

Future<UserProfile> fetchDetailProfile(int id) async {
  String? userToken = await getTokenFromSharedPreferences();

  final response = await http.get(
    Uri.parse('$serverPath/api/get-profile/${id.toString()}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8;',
      'Authorization': 'Bearer $userToken',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);

    final Map<String, dynamic> userData = data['data'];

    final UserProfile userProfile = UserProfile(
      id: userData['id'] ?? "",
      email: userData['email'] ?? "",
      phone: userData['phone'] ?? "",
      devicetoken: userData['device_token'] ?? "",
      isLiked: userData['liked'] == 1 ? true : false,
      profile: userData['profile'] ?? {},
      category: userData['category'] ?? {},
    );

    return userProfile;
  } else {
    throw Exception('HTTP request failed with status: ${response.statusCode}');
  }
}

Future<List<UserProfile>> searchUserProfiles(String searchText) async {
  String? userToken = await getTokenFromSharedPreferences();
  print(userToken);

  final response = await http.get(
    Uri.parse('$serverPath/api/search?search=$searchText'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8;',
      'Authorization': 'Bearer $userToken',
    },
  );
  print('$serverPath/api/search?search=$searchText');

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);

    if (data.containsKey('data')) {
      final List<dynamic> userDataList = data['data'];
      final List<UserProfile> profiles = userDataList
          .where((userData) => userData['user']['category'] != null)
          .map((userData) {
        final user = userData['user'];
        return UserProfile(
          id: userData['id'] ?? "",
          email: user['email'] ?? "",
          phone: user['phone'] ?? "",
          devicetoken: user['device_token'] ?? "",
          isLiked: user['liked'] == 1 ? true : false,
          profile: user['profile'] ?? {},
          category: user['category'] ?? {},
        );
      }).toList();

      final cacheDB = CacheDatabase();
      await cacheDB.insertCacheData(profiles);
      print(profiles);
      return profiles;
    } else {
      throw Exception('Data "data" tidak ditemukan dalam respons');
    }
  } else {
    throw Exception(response.statusCode);
  }
}

Future<List<UserProfile>> filterUserProfiles(String category) async {
  String? userToken = await getTokenFromSharedPreferences();
  print(userToken);

  final response = await http.get(
    Uri.parse('$serverPath/api/filter-categories?filter=$category'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8;',
      'Authorization': 'Bearer $userToken',
    },
  );
  print('$serverPath/api/filter-categories?filter=$category');

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);

    if (data.containsKey('data')) {
      final List<dynamic> userDataList =
          category == 'all' ? data['data'] : data['data'][0]['user'];
      final List<UserProfile> profiles = userDataList.where((userData) {
        if (category == 'all') {
          return userData['category'] != null;
        } else {
          return userData['category'] != null;
        }
      }).map((userData) {
        return UserProfile(
          id: userData['id'] ?? "",
          email: userData['email'] ?? "",
          phone: userData['phone'] ?? "",
          devicetoken: userData['device_token'] ?? "",
          isLiked: userData['liked'] == 1 ? true : false,
          profile: userData['profile'] ?? {},
          category: userData['category'] ?? {},
        );
      }).toList();

      print(profiles);
      return profiles;
    } else {
      throw Exception('Data "data" tidak ditemukan dalam respons');
    }
  } else {
    throw Exception(response.statusCode);
  }
}

Future<List<UserProfile>> fetchUserprofileDB() async {
  try {
    final cacheDB = CacheDatabase();
    final cachedData = await cacheDB.getCacheData();
    return cachedData ?? [];
  } catch (e) {
    print('Error fetching user profiles from cache database: $e');
    return [];
  }
}

Future<List<UserProfile>> fetchDBFirst() async {
  try {
    final cachedData = await fetchUserprofileDB();
    if (cachedData.isNotEmpty) {
      return cachedData;
    } else {
      final serverData = await fetchUserProfiles();
      final cacheDB = CacheDatabase();
      await cacheDB.insertCacheData(serverData);
      return serverData;
    }
  } catch (e) {
    print('Error fetching user profiles: $e');
    return [];
  }
}

Future<List<UserProfile>> fetchUserProfileServer() async {
  try {
    final serverData = await fetchUserProfiles();
    final cacheDB = CacheDatabase();
    await cacheDB.insertCacheData(serverData);
    return serverData;
  } catch (e) {
    print('Error fetching user profiles: $e');
    return [];
  }
}

Future<List<UserProfile>> fetchLikeProfiles() async {
  String? userToken = await getTokenFromSharedPreferences();
  print(userToken);

  final response = await http.get(
    Uri.parse('$serverPath/api/list-like'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8;',
      'Authorization': 'Bearer $userToken',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);

    if (data.containsKey('data')) {
      final List<dynamic> userLikes = data['data'];
      final List<UserProfile> profiles = userLikes.map((userLike) {
        final Map<String, dynamic> userData = userLike['user'];
        return UserProfile.fromJson(userData);
      }).toList();

      return profiles;
    } else {
      throw Exception('Data "data" tidak ditemukan dalam respons');
    }
  } else {
    throw Exception(response.statusCode);
  }
}

Future<List<UserProfile>> fetchLikedProfile() async {
  try {
    final profiles = await fetchLikeProfiles();
    return profiles;
  } catch (e) {
    print('Error fetching user profiles: $e');
    return [];
  }
}
