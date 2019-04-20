import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:core';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

final MasterDB masterDatabase = MasterDB(version: 1);

class MasterDB {
  final String _dbFileName = "Master.db";
  static Database _database;
  final int version;

  MasterDB({this.version});

  Future<Database> get database async {
    if(_database != null)
      {
        return _database;
      }

      /* Init lazily database */
    _database = await initDB();
    return _database;
  }

  removeDB() async {
    final db = await database;
    deleteDatabase(db.path);
  }

  initDB() async {
    Directory appDocumentDirectory = await getApplicationDocumentsDirectory();
    String path = join(appDocumentDirectory.path, _dbFileName);
    return await openDatabase(path, version: version, onOpen: (db){}, onCreate: (Database db, int version) {});
  }

  Future<bool> tableExists(String tableName) async {
    final db = await database;
    final count = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='{?}'", [tableName]);
    if(count.length > 0) {
      return true;
    }
    return false;
  }

  Future<void> createTable(String tableName, Map<String, String> params) async {
    final db = await database;
    String query = "CREATE TABLE ? (";
    
    for(int i = 0; i < params.length; i++) {
      query += "${params.keys.toList()[i]} ${params.values.toList()[i]}";
      if(i + 1 < params.length) {
        /* not the Last one */
        query += ',';
      }
    }
    query += ')';
    query.toUpperCase();
    
    await db.execute(query);
  }
  
  Future<void> dropTable(String tableName) async {
    final db = await database;
    await db.execute("DROP TABLE IF EXIST ?", [tableName]);
  }
}