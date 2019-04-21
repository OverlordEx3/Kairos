import 'dart:core';
import '../../models/AttendanceModel.dart' show Attendance;
import '../../models/PeopleModel.dart' show People;
import 'masterDb.dart' show masterDatabase;
import 'PeopleDB.dart' show peopleDatabase;
import 'ShiftDB.dart' show shiftDB;
import 'SectionDB.dart' show sectionDB;
import 'GroupDB.dart' show groupDB;

final AttendanceDB attendanceDB = AttendanceDB();

class AttendanceDB {
	final String tableName = "Attendance";
	final String primaryKey = 'id';

	AttendanceDB() {
		final Map<String, String> tableParams =
		{
			primaryKey : "INTEGER PRIMARY KEY",
			"attendance" : "INTEGER",
			"FOREIGN KEY(peopleFK)" : "REFERENCES ${peopleDatabase.tableName}(${peopleDatabase.primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE",
			"FOREIGN KEY(shiftFK)" : "REFERENCES ${shiftDB.tableName}(${shiftDB.primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE",
			"FOREIGN KEY(sectionFK)" : "REFERENCES ${sectionDB.tableName}(${sectionDB.primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE",
			"FOREIGN KEY(groupFK)" : "REFERENCES ${groupDB.tableName}(${groupDB.primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE"
		};

		masterDatabase.tableExists(tableName).then((result) {
			if(result == false) {
				masterDatabase.createTable(tableName, tableParams);
			}
		});
	}

	Future<Attendance> addAttendanceItem(bool attendance, int peopleID, int shiftID) async {
		final db = await masterDatabase.database;
		/* Calculate foreign keys from people ID */
		final people = await peopleDatabase.getPeopleById(peopleID);
		final attendanceItem = Attendance(attendance, peopleID, shiftID, await masterDatabase.getNextIDFromDB(tableName, primaryKey), people?.sectionID, people?.groupID);
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
		final query = await db.query(this.tableName, where: 'ShiftFK = ?', whereArgs: [shiftID]);
		return List.generate(query.length, (i) {
			return Attendance(
					(query[i]['attendant'] == 1) ? true : false,
				query[i]['personid'],
				query[i]['shiftID'],
				query[i]['id'],
				query[i]['section'],
				query[i]['group']
			);
		});
	}

	Future<List<Attendance>> getAttendanceByPerson(int personID) async {
		final db = await masterDatabase.database;
		final query = await db.query(this.tableName, where: 'peopleFK = ?', whereArgs: [personID]);
		return List.generate(query.length, (i) {
			return Attendance(
					(query[i]['attendant'] == 1) ? true : false,
					query[i]['personid'],
					query[i]['shiftID'],
					query[i]['id'],
					query[i]['section'],
					query[i]['group']
			);
		});
	}
}