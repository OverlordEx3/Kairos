import 'dart:async';

/* Model */
import '../models/SectionModel.dart';
import '../resources/LocalDatabase/SectionDB.dart';


class SectionLocalProvider {
	static final _instance = SectionLocalProvider._internal();

	factory SectionLocalProvider() => _instance;

	SectionLocalProvider._internal();

	Future<Section> addSection(Section item) async {
		return await SectionDB().addSection(item);
	}

	Future<int> deleteSection(int key) async {
		return await SectionDB().deleteSection(key);
	}

	Future<int> updateSection(Section section) async {
		return await SectionDB().updateSection(section);
	}

	Future<Section> getSectionById(int id) async {
		return await SectionDB().getSectionFromID(id);
	}

	Future<List<Section>> getAllSectionsFromGroup(int groupId) async {
		return await SectionDB().getAllSectionsFromGroup(groupId);
	}
}