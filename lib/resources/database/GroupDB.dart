import 'package:sqflite/sqflite.dart';
import 'dart:core';
import '../../models/GroupModel.dart' show Group;
import 'masterDb.dart' show masterDatabase;

final GroupDB groupDB = GroupDB();

class GroupDB {
	final String tableName = "group";
	final String primaryKey = 'id';

	GroupDB() {
		final Map<String, String> tableParams =
		{
			primaryKey : "INTEGER PRIMARY KEY",
			"groupname" : "TEXT"
		};

		masterDatabase.tableExists(tableName).then((result) {
			if(result == false) {
				masterDatabase.createTable(tableName, tableParams);
			}
		});
	}

	Future<Group> addGroup(String name) async {
		final db = await masterDatabase.database;
		final group = Group(name, await masterDatabase.getNextIDFromDB(this.tableName, this.primaryKey));
		await db.insert(tableName, group.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
		return group;
	}

	Future<int> updateGroup(Group group) async {
		final db = await masterDatabase.database;
		return await db.update(tableName, group.toMap(), where: '${this.primaryKey} = ?', whereArgs: [group.id]);
	}

	Future<int> deleteGroup(int key) async {
		final db = await masterDatabase.database;
		return await db.delete(tableName, where: '${this.primaryKey} = ?', whereArgs: [key]);
	}
}