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

  PeopleDB() {
    final Map<String, String> tableParams = {
      primaryKey: "INTEGER PRIMARY KEY",
      "name": "TEXT",
      "surname": "TEXT",
      "short": "TEXT",
      "imguri": "TEXT",
      "section":
          "REFERENCES ${sectionDB.tableName}(${sectionDB.primaryKey}) ON UPDATE CASCADE ON DELETE SET NULL",
      "group":
          "REFERENCES ${groupDB.tableName}(${groupDB.primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE",
      "hash": "INTEGER"
    };
    /* Check if table exists */
    masterDatabase.tableExists(tableName).then((result) {
      if (result == false) {
        masterDatabase.createTable(tableName, tableParams);
      }
    });
  }

  /*  People operation */
  Future<People> addPerson(
      String name, String surname, String shortBio, int section, int group,
      [String imgURI]) async {
    final db = await masterDatabase.database;
    People person = People(
        uniqueID: await masterDatabase.getNextIDFromDB(tableName, primaryKey),
        name: name,
        surname: surname,
        shortBio: shortBio,
        sectionID: section,
        groupID: group,
        imgURI: imgURI);
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

  Future<List<People>> getAllPeople() async {
    final db = await masterDatabase.database;
    final List<Map<String, dynamic>> dbResult = await db.query(tableName);

    return List.generate(dbResult.length, (i) {
      return People(
        uniqueID: dbResult[i]['uid'],
        name: dbResult[i]['name'],
        surname: dbResult[i]['surname'],
        shortBio: dbResult[i]['short'],
        sectionID: dbResult[i]['section'],
        groupID: dbResult[i]['groupid'],
        imgURI: dbResult[i]['imguri'],
      );
    });
  }
}
