import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/profile_model.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'profiles.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE profiles (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          contact TEXT,
          dob TEXT,
          qualification TEXT,
          imagePath TEXT
        )
      ''');
    });
  }

  Future<int> insertProfile(ProfileModel profile) async {
    final dbClient = await db;
    return await dbClient.insert("profiles", profile.toMap());
  }

  Future<List<ProfileModel>> getProfiles() async {
    final dbClient = await db;
    var res = await dbClient.query("profiles");
    return res.map((p) => ProfileModel.fromMap(p)).toList();
  }

  Future<int> updateProfile(ProfileModel profile) async {
    final dbClient = await db;
    return await dbClient.update(
      "profiles",
      profile.toMap(),
      where: "id = ?",
      whereArgs: [profile.id],
    );
  }
}
