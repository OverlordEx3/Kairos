import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:core';
import 'package:path_provider/path_provider.dart';

class MasterDB {
  MasterDB._();
  static final MasterDB db = MasterDB._();

  static Database _database;

  Future<Database> get database async {
    if(_database != null)
      {
        return _database;
      }

      /* Init lazily database */
    _database = await InitDB();
    return _database;
  }

  InitDB() async {
    Directory appDocumentDirectoy = await getApplicationDocumentsDirectory();
    String path = appDocumentDirectoy.path + "MasterDB.db";
    return await openDatabase(path, version: 1, onOpen: (db){}, onCreate: (Database db, int version) async{
      await db.execute("CREATE TABLE People ("
          "UID INTEGER PRIMARY KEY,"
          "name TEXT,"
          "surname TEXT,"
          "ID INTEGER,"
          "short TEXT,"
          "hash INTEGER)");
    });
  }


}