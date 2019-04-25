import 'package:sqflite/sqflite.dart';
import 'dart:core';
import '../../models/SectionModel.dart' show Section;
import 'masterDb.dart' show masterDatabase;
import 'GroupDB.dart' show groupDB;

final SectionDB sectionDB = SectionDB();

class SectionDB {
  final String tableName = "section";
  final String primaryKey = 'id';
  Map<String, String> tableParams;

  SectionDB() {
    tableParams = {
      primaryKey: "INTEGER PRIMARY KEY",
      "sectionname": "TEXT",
      "color": "INTEGER",
      "groupid":
          "INTEGER NOT NULL REFERENCES ${groupDB.tableName}(${groupDB.primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE"
    };
  }

  initTable() async {
    /* Check database */
    await masterDatabase.checkAndCreateTable(tableName, tableParams);
  }

  Future<Section> addSection(Map<String, dynamic> params) async {
    final db = await masterDatabase.database;
    var section = Section.fromMap(params);
    section.id = await masterDatabase.getNextIDFromDB(tableName, primaryKey);
    await db.insert(tableName, section.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return section;
  }

  Future<int> updateSection(Section section) async {
    final db = await masterDatabase.database;
    return await db.update(tableName, section.toMap(),
        where: '${this.primaryKey} = ?', whereArgs: [section.id]);
  }

  Future<int> deleteSection(int key) async {
    final db = await masterDatabase.database;
    return await db
        .delete(tableName, where: '${this.primaryKey} = ?', whereArgs: [key]);
  }

  Future<Section> getSectionFromID(int id) async {
    final db = await masterDatabase.database;
    final dbResult =
        await db.query(tableName, where: '$primaryKey = ?', whereArgs: [id]);

    return Section.fromMap(dbResult.first);
  }

  Future<List<Section>> getAllSectionsFromGroup(int groupID) async {
    final db = await masterDatabase.database;
    final List<Map<String, dynamic>> dbResult =
        await db.query(tableName, where: 'groupid = ?', whereArgs: [groupID]);

    return List.generate(dbResult.length, (i) {
      return Section.fromMap(dbResult[i]);
    });
  }
}
