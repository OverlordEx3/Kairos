import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

/* Ugly code :( */
import 'LocalDatabase/GroupDB.dart';
import 'LocalDatabase/SectionDB.dart';
import 'LocalDatabase/PeopleDB.dart';
import 'LocalDatabase/ShiftAttendanceDB.dart';

class MasterDatabase {
	final String _dbFileName = "KairosMaster.db";
	static Database _database;
	final int version = 1;
	static final MasterDatabase _instance = new MasterDatabase._internalInit();

	factory MasterDatabase () => _instance;
	MasterDatabase._internalInit();

	/* Get database instance */
	Future<Database> get database async {
		if(_database != null) return _database;

		_database = await initDB();
		return _database;
	}

	initDB() async {
		Directory appDocumentDirectory = await getApplicationDocumentsDirectory();
		String path = join(appDocumentDirectory.path, _dbFileName);
		return await openDatabase(path, version: this.version, singleInstance: true,
		onCreate: _onCreateDB);
	}

	void _onCreateDB(Database db, int version) async {
		await db.transaction((tx) {
			/* Create tables */
			var batch = tx.batch();
			batch.execute(_createTableStringByParams(GroupDB().tableName, GroupDB().tableParams));
			batch.execute(_createTableStringByParams(SectionDB().tableName, SectionDB().tableParams));
			batch.execute(_createTableStringByParams(PeopleDB().tableName, PeopleDB().tableParams));
			batch.execute(_createTableStringByParams(ShiftAttendanceDB().shiftTableName, ShiftAttendanceDB().shiftTableParams));
			batch.execute(_createTableStringByParams(ShiftAttendanceDB().attendanceTableName, ShiftAttendanceDB().attendanceTableParams));
		});
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

	Future<int> getNextIDFromDB(String tableName, String primaryKey, {Batch batch}) async {
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