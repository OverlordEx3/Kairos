import 'package:sqflite/sqflite.dart';
import '../../models/SectionModel.dart';
import '../MasterDatabase.dart';
import 'GroupDB.dart';

class SectionDB {
  final String tableName = 'section';
  final String primaryKey = 'id';
  Map<String, String> tableParams;
  static final _instance = SectionDB._internal();

  factory SectionDB() => _instance;

  SectionDB._internal() {
    tableParams = {
      primaryKey: "INTEGER PRIMARY KEY",
      "name": "TEXT",
      "color": "INTEGER",
      "groupid":
      "INTEGER NOT NULL REFERENCES ${GroupDB().tableName}(${GroupDB().primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE"
    };
  }

  Future<Section> addSection(Section section) async {
    final db = await MasterDatabase().database;
    section.id = await MasterDatabase().getNextIDFromDB(tableName, primaryKey);
    var insert = await db.insert(tableName, section.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    if(insert > 0) {
      return section;
    }

    return null;
  }

  Future<int> updateSection(Section section) async {
    final db = await MasterDatabase().database;
    return await db.update(tableName, section.toMap(),
        where: '${this.primaryKey} = ?', whereArgs: [section.id]);
  }

  Future<int> deleteSection(int key) async {
    final db = await MasterDatabase().database;
    return await db
        .delete(tableName, where: '${this.primaryKey} = ?', whereArgs: [key]);
  }

  Future<Section> getSectionFromID(int id) async {
    final db = await MasterDatabase().database;
    final dbResult =
        await db.query(tableName, where: '$primaryKey = ?', whereArgs: [id]);

    return Section.fromMap(dbResult.first);
  }

  Future<List<Section>> getAllSectionsFromGroup(int groupID) async {
    final db = await MasterDatabase().database;
    final List<Map<String, dynamic>> dbResult =
        await db.query(tableName, where: 'groupid = ?', whereArgs: [groupID]);

    return List.generate(dbResult.length, (i) {
      return Section.fromMap(dbResult[i]);
    });
  }
}
