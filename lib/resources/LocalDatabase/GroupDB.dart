import 'package:sqflite/sqflite.dart';
import '../../models/GroupModel.dart' show Group;
import '../MasterDatabase.dart';

class GroupDB {
	final String tableName = "SGroup";
	final String primaryKey = 'id';
	Map<String, String> tableParams;
	static final _instance = GroupDB._internal();

	factory GroupDB() => _instance;

	GroupDB._internal() {
		tableParams =
		{
			primaryKey : "INTEGER PRIMARY KEY",
			"name" : "TEXT"
		};
	}

	Future<Group> addGroup(Group group) async {
		final db = await MasterDatabase().database;
		group.id = await MasterDatabase().getNextIDFromDB(tableName, primaryKey);
		var insert = await db.insert(tableName, group.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
		if(insert > 0) {
			return group;
		}

		return null;
	}

	Future<int> updateGroup(Group group) async {
		final db = await MasterDatabase().database;
		return await db.update(tableName, group.toMap(), where: '${this.primaryKey} = ?', whereArgs: [group.id]);
	}

	Future<int> deleteGroup(int key) async {
		final db = await MasterDatabase().database;
		return await db.delete(tableName, where: '${this.primaryKey} = ?', whereArgs: [key]);
	}

	Future<Group> getGroupById(int id) async {
		final db = await MasterDatabase().database;
		final dbResult = await db.query(tableName, where: '${this.primaryKey} = ?', whereArgs: [id]);

		if(dbResult.length == 0) {
			return null;
		}

		return Group.fromMap(dbResult.first);
	}
}