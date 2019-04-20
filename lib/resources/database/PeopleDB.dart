import 'package:sqflite/sqflite.dart';
import 'dart:core';
import '../../models/PeopleModel.dart';
import 'masterDb.dart' show masterDatabase;

final PeopleDB peopleDatabase = PeopleDB();

class PeopleDB {
	final String tableName = "People";

	PeopleDB() {
		final Map<String, String> tableParams =
		{
			"uid" : "INTEGER PRIMARY KEY",
			"name" : "TEXT",
			"surname" : "TEXT",
			"short" : "TEXT",
			"section" : "INTEGER",
			"hash" : "INTEGER"
		};
		/* Check if table exists */
		masterDatabase.tableExists(tableName).then((result) {
			if(result == false) {
				masterDatabase.createTable(tableName, tableParams);
			}
		});
	}

	/*  People operation */
	Future<People> addPerson(String name, String surname, String shortBio, int section) async {
		final db = await masterDatabase.database;
		People person = People(uniqueID: await _getNextIDFromDB(), name: name, surname: surname, shortBio: shortBio, sectionID: section);
		await db.insert(tableName, person.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

		return person;
	}

	Future<int> updatePerson(People person) async {
		final db = await masterDatabase.database;
		return await db.update(tableName, person.toMap(), where: 'uid = ?', whereArgs: [person.uid]);
	}

	Future<int> deletePerson(int key) async {
		final db = await masterDatabase.database;
		return await db.delete(tableName, where: 'uid = ?', whereArgs: [key]);
	}

	Future<List<People>> getAllPeople() async {
		final db = await masterDatabase.database;
		final List<Map<String, dynamic>> dbResult = await db.query(tableName);

		return List.generate(dbResult.length, (i) {
			return People(
					uniqueID: dbResult[i]['uid'],
					name: dbResult[i]['name'],
					surname: dbResult[i]['surname'],
					shortBio: dbResult[i]['short'],
					sectionID: dbResult[i]['section']
			);
		});
	}

	Future<int> _getNextIDFromDB() async {
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