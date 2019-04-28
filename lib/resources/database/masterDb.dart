import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:core';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

/* Ugly but, for now, needed code. */
import 'PeopleDB.dart';
import 'GroupDB.dart';
import 'AttendanceDB.dart';
import 'SectionDB.dart';
import 'ShiftDB.dart';

final MasterDB masterDatabase = MasterDB(version: 3);

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
    return await openDatabase(path, version: version, onCreate: _onCreateDB,
    onConfigure: (Database db) async {
      return await db.execute("PRAGMA foreign_keys = ON");
    },
    onDowngrade: onDatabaseDowngradeDelete,
    onOpen: (Database db) async => print(await db.query('sqlite_master')));
  }

  String _createTableStringByParams(String tableName, Map<String, String> tableParams) {
    String query = "CREATE TABLE IF NOT EXISTS $tableName (";

    for(int i = 0; i < tableParams.length; i++) {
      query += "${tableParams.keys.toList()[i]} ${tableParams.values.toList()[i]}";
      if(i + 1 < tableParams.length) {
        /* not the Last one */
        query += ',';
      }
    }
    query += ')';

    print(query);
    return query;
  }

  void _onCreateDB(Database db, int version) async {
    await db.transaction((tx) async {
      /* Create tables */
      var batch = tx.batch();
      batch.execute(_createTableStringByParams(groupDB.tableName, groupDB.tableParams));
      batch.execute(_createTableStringByParams(sectionDB.tableName, sectionDB.tableParams));
      batch.execute(_createTableStringByParams(peopleDatabase.tableName, peopleDatabase.tableParams));
      batch.execute(_createTableStringByParams(shiftDB.tableName, shiftDB.tableParams));
      batch.execute(_createTableStringByParams(attendanceDB.tableName, attendanceDB.tableParams));

      /* Insert default group */
      batch.insert(groupDB.tableName,{
        'groupname' : 'default',
        'id': 0
      });

      batch.insert(sectionDB.tableName, {
        'sectionname' : 'default',
        'id' : 0,
        'color' : 0x00000000,
        'groupid' : 0
      });

      await batch.commit();
    });

  }

  checkAndCreateTable(String tableName, Map<String, String> tableParams) async {
    /* Check if table exists */
    final exist = await tableExists(tableName);
    if(!exist) {
      await createTable(tableName, tableParams);
    }
  }

  Future<bool> tableExists(String tableName) async {
    final db = await database;
    final count = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name=?", [tableName]);
    if(count.length > 0) {
      return true;
    }
    return false;
  }

  Future<void> createTable(String tableName, Map<String, String> params) async {
    final db = await database;
    String query = _createTableStringByParams(tableName, params);
    await db.execute(query);
  }
  
  Future<void> dropTable(String tableName) async {
    final db = await database;
    await db.execute("DROP TABLE IF EXIST ?", [tableName]);
  }

  Future<int> getNextIDFromDB(String tableName, String primaryKey) async {
    final db = await database;
    var dbQuery = await db.query(tableName, columns: ['COALESCE(MAX($primaryKey)+1, 0)']);
    if(dbQuery.length > 0) {
      var ret = Sqflite.firstIntValue(dbQuery);
      return ret;
    } else {
      return 0;
    }
  }
}