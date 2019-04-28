import 'dart:core';
import '../../models/AttendanceModel.dart' show Attendance;
import 'masterDb.dart' show masterDatabase;
import 'PeopleDB.dart' show peopleDatabase;
import 'ShiftDB.dart' show shiftDB;
import 'SectionDB.dart' show sectionDB;
import 'GroupDB.dart' show groupDB;

final AttendanceDB attendanceDB = AttendanceDB();

class AttendanceDB {
	final String tableName = "Attendance";
	final String primaryKey = 'id';
	Map<String, String> tableParams;

	AttendanceDB() {
		tableParams =
		{
			primaryKey : "INTEGER PRIMARY KEY",
			"attendance" : "INTEGER",
			"personid" : "INTEGER NOT NULL REFERENCES ${peopleDatabase.tableName}(${peopleDatabase.primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE",
			"shiftid" : "INTEGER NOT NULL REFERENCES ${shiftDB.tableName}(${shiftDB.primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE",
			"sectionid" : "INTEGER REFERENCES ${sectionDB.tableName}(${sectionDB.primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE",
			"groupid" : "INTEGER NOT NULL REFERENCES ${groupDB.tableName}(${groupDB.primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE",
		};
	}

	initTable() async {
		/* Check database */
		await masterDatabase.checkAndCreateTable(tableName, tableParams);
	}

	Future<Attendance> addAttendanceItem(Map<String, dynamic> params) async {
		final db = await masterDatabase.database;
		var attendanceItem = Attendance.fromMap(params);
		await db.insert(this.tableName, attendanceItem.toMap());

		return attendanceItem;
	}

	Future<int> updateAttendanceItem(Attendance item) async {
		final db = await masterDatabase.database;
		return await db.update(this.tableName, item.toMap(), where: '$primaryKey = ?', whereArgs: [item.id]);
	}

	Future<int> deleteAttendanceItem(int key) async {
		final db = await masterDatabase.database;
		return await db.delete(this.tableName, where: '$primaryKey = ?', whereArgs: [key]);
	}

	Future<Attendance> getAttendanceItem(int id) async {
		final db = await masterDatabase.database;
		final query = await db.query(this.tableName, where: '${this.primaryKey} = ?', whereArgs: [id]);
		return Attendance.fromMap(query.first);
	}

	Future<List<Attendance>> getAttendanceByShift(int shiftID) async {
		final db = await masterDatabase.database;
		final query = await db.query(this.tableName, where: 'shiftid = ?', whereArgs: [shiftID]);
		return List.generate(query.length, (i) {
			return Attendance.fromMap(query[i]);
		});
	}

	Future<List<Attendance>> getAttendanceByPerson(int personID) async {
		final db = await masterDatabase.database;
		final query = await db.query(this.tableName, where: 'personid = ?', whereArgs: [personID]);
		return List.generate(query.length, (i) {
			return Attendance.fromMap(query[i]);
		});
	}
}