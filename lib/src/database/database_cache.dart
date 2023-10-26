import 'dart:convert';
import 'package:prt/src/api/fetch_user_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE IF NOT EXISTS cache_data ('
        'id INTEGER PRIMARY KEY, '
        'data TEXT)');
  }

  Future<void> insertCacheData(List<UserProfile> userProfiles) async {
    final db = await database;
    final jsonData = jsonEncode(userProfiles);
    await db.insert(
      'cache_data',
      {'data': jsonData},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UserProfile>?> getCacheData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('cache_data', orderBy: 'id DESC', limit: 1);

    if (maps.isNotEmpty) {
      final map = maps.first;
      final jsonData = map['data'] as String;
      final userProfiles = (jsonDecode(jsonData) as List<dynamic>)
          .map((data) => UserProfile(
                email: data['email'],
                phone: data['phone'],
                isLiked: data['is_liked'] == 1,
                profile: data['profile'],
                category: data['category'],
              ))
          .toList();
      return userProfiles;
    }
    return null;
  }
}
