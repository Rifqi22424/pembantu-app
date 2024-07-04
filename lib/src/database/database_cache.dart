import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../api/fetch_user_data.dart';
import 'user_profile_table.dart';

class CacheDatabase {
  static final CacheDatabase _instance = CacheDatabase._internal();
  factory CacheDatabase() => _instance;

  static Database? _database;

  CacheDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'cache_database.db');
    print('Database path: $path');

    final db = await openDatabase(path, version: 1, onCreate: _onCreate);
    print('Database opened successfully');

    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await UserProfilesTable.onCreate(db, version);
  }

  Future<void> insertCacheData(List<UserProfile> userProfiles) async {
    final db = await database;
    final batch = db.batch();

    for (final profile in userProfiles) {
      batch.insert(
        'user_profiles',
        profile.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
  }

  Future<List<UserProfile>?> getCacheData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('user_profiles', orderBy: 'id DESC', limit: 1);

    if (maps.isNotEmpty) {
      final map = maps.first;
      final jsonData = map['data'] as String?;

      if (jsonData != null) {
        final userProfiles = (jsonDecode(jsonData) as List<dynamic>)
            .map((data) => UserProfile.fromMap(data))
            .toList();
        return userProfiles;
      }
    }
    return null;
  }
}
