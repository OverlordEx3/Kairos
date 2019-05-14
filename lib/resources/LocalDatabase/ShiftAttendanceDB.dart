import 'package:sqflite/sqflite.dart';

import '../../models/AttendanceModel.dart';
import '../../models/ShiftModel.dart';
import '../MasterDatabase.dart';

import 'GroupDB.dart';
import 'SectionDB.dart';
import 'PeopleDB.dart';

class ShiftAttendanceDB {
	final String shiftTableName = 'section';
	final String shiftPrimaryKey = 'id';
	Map<String, String> shiftTableParams;

	final String attendanceTableName = 'Attendance';
	final String attendancePrimaryKey = 'id';
	Map<String, String> attendanceTableParams;

	static final _instance = ShiftAttendanceDB._internal();

	factory ShiftAttendanceDB() => _instance;

	ShiftAttendanceDB._internal() {
		shiftTableParams = {
			shiftPrimaryKey: "INTEGER PRIMARY KEY",
			"name": "TEXT",
			"color": "INTEGER",
			"groupid":
			"INTEGER NOT NULL REFERENCES ${GroupDB().tableName}(${GroupDB().primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE"
		};

		attendanceTableParams =
		{
			attendancePrimaryKey : "INTEGER PRIMARY KEY",
			"attendance" : "INTEGER",
			"personid" : "INTEGER NOT NULL REFERENCES ${PeopleDB().tableName}(${PeopleDB().primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE",
			"shiftid" : "INTEGER NOT NULL REFERENCES $shiftTableName($shiftPrimaryKey) ON UPDATE CASCADE ON DELETE CASCADE",
			"sectionid" : "INTEGER REFERENCES ${SectionDB().tableName}(${SectionDB().primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE",
			"groupid" : "INTEGER NOT NULL REFERENCES ${GroupDB().tableName}(${GroupDB().primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE",
		};
	}

	Future<Shift> addShift(Shift shift) async {
		final db = await MasterDatabase().database;
		shift.id = await MasterDatabase().getNextIDFromDB(shiftTableName, shiftPrimaryKey);
		var result = await db.insert(shiftTableName, shift.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

		if(result > 0) {
			return shift;
		}

		return null;
	}

	Future<int> updateShift(Shift shift) async {
		final db = await MasterDatabase().database;
		return await db.update(shiftTableName, shift.toMap(), where: '$shiftPrimaryKey = ?', whereArgs: [shift.id]);
	}

	Future<int> deleteShift(int key) async {
		final db = await MasterDatabase().database;
		return await db.delete(shiftTableName, where: '$shiftPrimaryKey = ?', whereArgs: [key]);
	}

	Future<List<Shift>> getShiftsBy({int groupId, int sectionId, List<int> id}) async {
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

			whereClause += 'IN $shiftPrimaryKey (?)';
			whereArgs.add(id.join(','));
		}

		var db = await MasterDatabase().database;
		var dbQuery = await db.query(shiftTableName, where: whereClause, whereArgs: whereArgs);

		return List.generate(dbQuery.length, (i) {
			return Shift.fromMap(dbQuery[i]);
		});
	}

	Future<Attendance> addAttendanceItem(Attendance item) async {
		final db = await MasterDatabase().database;
		var result = await db.insert(attendanceTableName, item.toMap());
		if(result > 0) {
			return item;
		}

		return null;
	}

	Future<List<Attendance>> addListAttendanceItems(List<Attendance> items) async {
		items.forEach((attendance) async {
			addAttendanceItem(attendance);
		});

		return items;
	}

	Future<int> updateAttendanceItem(Attendance item) async {
		final db = await MasterDatabase().database;
		return await db.update(attendanceTableName, item.toMap(), where: '$attendancePrimaryKey = ?', whereArgs: [item.id]);
	}

	Future<int> deleteAttendanceItem(Attendance item) async {
		final db = await MasterDatabase().database;
		return await db.delete(attendanceTableName, where: '$attendancePrimaryKey = ?', whereArgs: [item.id]);
	}

	Future<Attendance> getAttendanceItem(int id) async {
		final db = await MasterDatabase().database;
		final query = await db.query(attendanceTableName, where: '$attendancePrimaryKey = ?', whereArgs: [id]);
		if(query.length > 0) {
			return Attendance.fromMap(query.first);
		}

		return null;
	}

	Future<List<Attendance>> getAttendanceBy({int groupId, int sectionId, int personId, int shiftId, List<int> id}) async {
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

		if(personId != null) {
			if(nonUnique == true) {
				whereClause += ' AND ';
			}
			whereClause += 'personid=?';
			whereArgs.add(personId);
			nonUnique = true;
		}

		if(shiftId != null) {
			if(nonUnique == true) {
				whereClause += ' AND ';
			}
			whereClause += 'shiftid=?';
			whereArgs.add(shiftId);
			nonUnique = true;
		}

		if(id != null && id.length > 0) {
			if (nonUnique == true) {
				whereClause += ' ';
			}

			whereClause += 'IN $attendancePrimaryKey (?)';
			whereArgs.add(id.join(','));
		}

		var db = await MasterDatabase().database;
		var dbQuery = await db.query(attendanceTableName, where: whereClause, whereArgs: whereArgs);

		return List.generate(dbQuery.length, (i) {
			return Attendance.fromMap(dbQuery[i]);
		});
	}
}
