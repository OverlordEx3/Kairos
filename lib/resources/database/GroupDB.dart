import 'package:sqflite/sqflite.dart';
import 'dart:core';
import '../../models/GroupModel.dart' show Group;
import 'masterDb.dart' show masterDatabase;

final GroupDB groupDB = GroupDB();

class GroupDB {
	final String tableName = "SGroup";
	final String primaryKey = 'id';
	Map<String, String> tableParams;

	GroupDB() {
		tableParams =
		{
			primaryKey : "INTEGER PRIMARY KEY",
			"groupname" : "TEXT"
		};
	}

	initTable() async {
		/* Check database */
		await masterDatabase.checkAndCreateTable(tableName, tableParams);
	}

	Future<Group> addGroup(Map<String, dynamic> params) async {
		final db = await masterDatabase.database;
		final group = Group.fromMap(params);
		group.id = await masterDatabase.getNextIDFromDB(tableName, primaryKey);
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

	Future<Group> getGroupById(int id) async {
		final db = await masterDatabase.database;
		final dbResult = await db.query(tableName, where: '${this.primaryKey} = ?', whereArgs: [id]);

		if(dbResult.length == 0) {
			return null;
		}

		return Group.fromMap(dbResult.first);
	}
}