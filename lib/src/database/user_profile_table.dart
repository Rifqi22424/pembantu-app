import 'package:sqflite/sqflite.dart';

import '../api/fetch_user_data.dart';

class UserProfilesTable {
  static const String tableName = 'user_profiles';

  static Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        phone TEXT,
        devicetoken TEXT,
        isLiked INTEGER,
        profile TEXT,
        category TEXT
      )
    ''');
  }

  static Future<void> insertUserProfiles(Database db, List<UserProfile> userProfiles) async {
    final batch = db.batch();
    for (final userProfile in userProfiles) {
      batch.insert(
        tableName,
        userProfile.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  static Future<List<UserProfile>> getUserProfiles(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (index) {
      return UserProfile.fromMap(maps[index]);
    });
  }
}
