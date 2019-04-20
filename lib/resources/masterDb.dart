import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:core';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import '../models/PeopleModel.dart';

final MasterDB masterDatabase = MasterDB();

class MasterDB {
  static Database _database;

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
    String path = join(appDocumentDirectory.path, "MasterDB.db");
    return await openDatabase(path, version: 2, onOpen: (db){}, onCreate: (Database db, int version) async{
      await db.execute("CREATE TABLE People ("
          "uid INTEGER PRIMARY KEY,"
          "name TEXT,"
          "surname TEXT,"
          "short TEXT,"
          "hash INTEGER,"
          "section INTEGER)");
    });
  }

  /*  People operation */
  Future<People> addPeopleToDB(String name, String surname, String shortBio, int section) async {
    final db = await database;
    People person = People(uniqueID: await getNextIDFromDB(), name: name, surname: surname, shortBio: shortBio, sectionID: section);
    await db.insert('People', person.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

    return person;
  }

  Future<int> updatePeopleToDB(People person) async {
    final db = await database;
    return await db.update('People', person.toMap(), where: 'uid = ?', whereArgs: [person.uid]);
  }

  Future<int> deletePersonFromDB(int key) async {
    final db = await database;
    return await db.delete('People', where: 'uid = ?', whereArgs: [key]);
  }

  Future<List<People>> getAllPeopleFromDB() async {
    final db = await database;
    final List<Map<String, dynamic>> dbResult = await db.query('People');
    
    return List.generate(dbResult.length, (i) {
      return People(
        uniqueID: dbResult[i]['uid'],
        name: dbResult[i]['name'],
        surname: dbResult[i]['surname'],
        shortBio: dbResult[i]['short'],
        sectionID: dbResult[i]['section']
      );
    });
  }

  Future<int> getNextIDFromDB() async {
    final db = await database;
    var dbQuery = await db.rawQuery('SELECT COALESCE(MAX(uid)+1, 0) FROM People ');
    if(dbQuery.length > 0) {
      var ret = Sqflite.firstIntValue(dbQuery);
      return ret;
    } else {
      return 0;
    }
  }
}