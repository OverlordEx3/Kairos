import 'package:sqflite/sqflite.dart';
import '../../models/PeopleModel.dart';
import '../MasterDatabase.dart';
import 'SectionDB.dart';
import 'GroupDB.dart';

class PeopleDB {
  final String tableName = "People";
  final String primaryKey = 'uid';
  Map<String, String> tableParams;
  static final _instance = PeopleDB._internal();

  factory PeopleDB() {
    return _instance;
  }

  PeopleDB._internal() {
    tableParams = {
      primaryKey: "INTEGER PRIMARY KEY",
      "name": "TEXT",
      "surname": "TEXT",
      "bio": "TEXT",
      "imageuri": "TEXT",
      "section":
          "INTEGER DEFAULT NULL REFERENCES ${SectionDB().tableName}(${SectionDB().primaryKey}) ON UPDATE CASCADE ON DELETE SET NULL",
      "group":
          "INTEGER NOT NULL REFERENCES ${GroupDB().tableName}(${GroupDB().primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE"
    };
  }

  /*  People operation */
  Future<People> addPerson(People person) async {
    final db = await MasterDatabase().database;
    person.id = await MasterDatabase().getNextIDFromDB(tableName, primaryKey);
    var inserted = await db.insert(tableName, person.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    if(inserted > 0) {
      return person;
    }
    return null;
  }

  Future<int> updatePerson(People person) async {
    final db = await MasterDatabase().database;
    return await db.update(tableName, person.toMap(), where: '$primaryKey = ?', whereArgs: [person.id]);
  }

  Future<int> deletePerson(int key) async {
    final db = await MasterDatabase().database;
    return await db.delete(tableName, where: '$primaryKey = ?', whereArgs: [key]);
  }

  Future<People> getPersonById(int id) async {
    final db = await MasterDatabase().database;
    final dbResult = await db.query(tableName, where: '${this.primaryKey} = ?', whereArgs: [id]);
    if (dbResult.length == 0) {
      return null;
    }

    return People.fromMap(dbResult.first);
  }

  Future<List<People>> getPeopleBy({int groupId, int sectionId, List<int> id}) async {
    bool nonUnique = false;
    String whereClause;
    List<dynamic> whereArgs;

    if(groupId != null) {
    whereClause += 'group=?';
    whereArgs.add(groupId);
    nonUnique = true;
    }

    if(sectionId != null) {
      if(nonUnique == true) {
        whereClause += ' AND ';
      }
      whereClause += 'section=?';
      whereArgs.add(sectionId);
      nonUnique = true;
    }

    if(id != null && id.length > 0) {
      if (nonUnique == true) {
        whereClause += ' ';
      }

      whereClause += 'IN $primaryKey (?)';
      whereArgs.add(id.join(','));
    }

    var db = await MasterDatabase().database;
    var dbQuery = await db.query(tableName, where: whereClause, whereArgs: whereArgs);

    return List.generate(dbQuery.length, (i) {
      return People.fromMap(dbQuery[i]);
    });
  }
}
