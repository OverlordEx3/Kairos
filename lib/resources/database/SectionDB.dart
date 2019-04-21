import 'package:sqflite/sqflite.dart';
import 'dart:core';
import '../../models/SectionModel.dart' show Section;
import 'masterDb.dart' show masterDatabase;
import 'GroupDB.dart' show groupDB;

final SectionDB sectionDB = SectionDB();

class SectionDB {
	final String tableName = "section";
	final String primaryKey = 'id';

	SectionDB() {
		final Map<String, String> tableParams =
		{
			primaryKey : "INTEGER PRIMARY KEY",
			"sectionname" : "TEXT",
			"color" : "INTEGER",
			"FOREING KEY(groupFK)" : "REFERENCES ${groupDB.tableName}(${groupDB.primaryKey}) ON UPDATE CASCADE ON DELETE CASCADE"
		};

		masterDatabase.tableExists(tableName).then((result) {
			if(result == false) {
				masterDatabase.createTable(tableName, tableParams);
			}
		});
	}

	Future<Section> addSection(String name, int color, int groupID) async {
		final db = await masterDatabase.database;
		final section = Section(name, await masterDatabase.getNextIDFromDB(tableName, primaryKey), color, groupID);
		await db.insert(tableName, section.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
		return section;
	}

	Future<int> updateSection(Section section) async {
		final db = await masterDatabase.database;
		return await db.update(tableName, section.toMap(), where: '${this.primaryKey} = ?', whereArgs: [section.id]);
	}

	Future<int> deleteSection(int key) async {
		final db = await masterDatabase.database;
		return await db.delete(tableName, where: '${this.primaryKey} = ?', whereArgs: [key]);
	}

	Future<List<Section>> getAllSectionsFromGroup(int groupID) async {
		final db = await masterDatabase.database;
		final List<Map<String, dynamic>> dbResult = await db.query(tableName, where: 'groupFK = ?', whereArgs: [groupID]);

		return List.generate(dbResult.length, (i) {
			return Section(
				dbResult[i]['name'],
				dbResult[i]['id'],
				dbResult[i]['color'],
				dbResult[i]['group']
			);
		});
	}
}