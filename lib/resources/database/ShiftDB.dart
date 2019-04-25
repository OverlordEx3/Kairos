import 'package:sqflite/sqflite.dart';
import 'dart:core';
import '../../models/ShiftModel.dart' show ShiftStatus, Shift;
import 'masterDb.dart' show masterDatabase;

final ShiftDB shiftDB = ShiftDB();

class ShiftDB {
	final String tableName = "Shift";
	final String primaryKey = 'uid';
	Map<String, String> tableParams;

	ShiftDB() {
		tableParams =
		{
			primaryKey : "INTEGER PRIMARY KEY",
			"date" : "INTEGER",
			"status" : "INTEGER"
		};
	}

	initTable() async {
		/* Check database */
		await masterDatabase.checkAndCreateTable(tableName, tableParams);
	}

	Future<Shift> addShift(Map<String, dynamic> params) async {
		final db = await masterDatabase.database;
		var shift = Shift.fromMap(params);
		shift.uid = await masterDatabase.getNextIDFromDB(tableName, primaryKey);
		await db.insert(tableName, shift.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

		return shift;
	}

	Future<int> updateShift(Shift shift) async {
		final db = await masterDatabase.database;
		return await db.update(tableName, shift.toMap(), where: '$primaryKey = ?', whereArgs: [shift.uid]);
	}

	Future<int> deleteShift(int key) async {
		final db = await masterDatabase.database;
		return await db.delete(tableName, where: '$primaryKey = ?', whereArgs: [key]);
	}

	Future<List<Shift>> getAllShifts() async {
		final db = await masterDatabase.database;
		final List<Map<String, dynamic>> dbResult = await db.query(tableName);

		return List.generate(dbResult.length, (i) {
			return Shift.fromMap(dbResult[i]);
		});
	}
}