import 'package:sqflite/sqflite.dart';
import 'dart:core';
import '../../models/PeopleModel.dart';
import 'masterDb.dart' show masterDatabase;
import 'SectionDB.dart' show sectionDB;
import 'GroupDB.dart' show groupDB;

final PeopleDB peopleDatabase = PeopleDB();

class PeopleDB {
  final String tableName = "People";
  final String primaryKey = 'uid';
  Map<String, String> tableParams;

  PeopleDB() {
    tableParams = {
      primaryKey: "INTEGER PRIMARY KEY",
      "name": "TEXT",
      "surname": "TEXT",
      "short": "TEXT",
      "imguri": "TEXT",
      "sectionid" : "INTEGER DEFAULT NULL REFERENCES ${sectionDB.tableName}(${sectionDB.primaryKey}) ON UPDATE CASCADE ON DELETE SET NULL",
      "groupid" : "INTEGER NOT NULL REFERENCES ${groupDB.tableName}(${groupDB.primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE"
    };
  }

  initTable() async {
    /* Check database */
    await masterDatabase.checkAndCreateTable(tableName, tableParams);
  }

  /*  People operation */
  Future<People> addPerson(
      Map<String, dynamic> params) async {
    final db = await masterDatabase.database;
    final person = People.fromMap(params);
    person.uid = await masterDatabase.getNextIDFromDB(tableName, primaryKey);
    await db.insert(tableName, person.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return person;
  }

  Future<int> updatePerson(People person) async {
    final db = await masterDatabase.database;
    return await db.update(tableName, person.toMap(),
        where: '$primaryKey = ?', whereArgs: [person.uid]);
  }

  Future<int> deletePerson(int key) async {
    final db = await masterDatabase.database;
    return await db
        .delete(tableName, where: '$primaryKey = ?', whereArgs: [key]);
  }

  Future<People> getPeopleById(int id) async {
    final db = await masterDatabase.database;
    final dbResult = await db.query(tableName, where: '${this.primaryKey} = ?', whereArgs: [id]);

    if(dbResult.length == 0) {
      return null;
    }

    return People.fromMap(dbResult.first);
  }

  Future<List<People>> getAllPeople() async {
    final db = await masterDatabase.database;
    final List<Map<String, dynamic>> dbResult = await db.query(tableName);

    return List.generate(dbResult.length, (i) {
      return People.fromMap(dbResult[i]);
    });
  }
}
