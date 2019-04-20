import 'package:sqflite/sqflite.dart';
import 'dart:core';
import '../../models/ShiftModel.dart' show ShiftStatus, Shift;
import 'masterDb.dart' show masterDatabase;

final ShiftDB shiftDB = ShiftDB();

class ShiftDB {
	final String tableName = "Shift";

	ShiftDB() {
		final Map<String, String> tableParams =
		{
			"uid" : "INTEGER PRIMARY KEY",
			"date" : "INTEGER",
			"status" : "INTEGER"
		};

		masterDatabase.tableExists(tableName).then((result) {
			if(result == false) {
				masterDatabase.createTable(tableName, tableParams);
			}
		});
	}

	Future<Shift> addShift(DateTime date, ShiftStatus status) async {
		final db = await masterDatabase.database;
		final shift = Shift(uid: await getNextIDFromDB(), status: status, date: date.millisecondsSinceEpoch);
		await db.insert(tableName, shift.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

		return shift;
	}

	Future<int> updateShift(Shift shift) async {
		final db = await masterDatabase.database;
		return await db.update(tableName, shift.toMap(), where: 'uid = ?', whereArgs: [shift.uid]);
	}

	Future<int> deleteShift(int key) async {
		final db = await masterDatabase.database;
		return await db.delete(tableName, where: 'uid = ?', whereArgs: [key]);
	}

	Future<List<Shift>> getAllShifts() async {
		final db = await masterDatabase.database;
		final List<Map<String, dynamic>> dbResult = await db.query(tableName);

		return List.generate(dbResult.length, (i) {
			return Shift(
				uid: dbResult[i]['uid'],
				date: dbResult[i]['date'],
				status: dbResult[i]['status']
			);
		});
	}

	Future<int> getNextIDFromDB() async {
		final db = await masterDatabase.database;
		var dbQuery = await db.rawQuery('SELECT COALESCE(MAX(uid)+1, 0) FROM ?', [tableName]);
		if(dbQuery.length > 0) {
			var ret = Sqflite.firstIntValue(dbQuery);
			return ret;
		} else {
			return 0;
		}
	}
}