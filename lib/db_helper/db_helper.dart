import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, vesrion) {
          
      return db.execute(
          'CREATE TABLE userPlaces(id TEXT PRIMARY KEY,title TEXT,image TEXT,lat REAL,long REAL)');
          
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> mp) async {
    final db = await DBHelper.database();
    
    
      db.insert(table, mp, conflictAlgorithm: ConflictAlgorithm.replace);
    
  }

  static Future<List<Map<String, dynamic>>> fetch(String table) async {
    final db = await DBHelper.database();
    
    return db.query(table);
  }
}
