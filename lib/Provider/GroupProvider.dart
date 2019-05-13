import 'dart:async';

/* Models */
import '../models/GroupModel.dart';
import '../resources/LocalDatabase/GroupDB.dart';

class GroupLocalProvider {
	static final _instance = GroupLocalProvider._internal();
	factory GroupLocalProvider() => _instance;
	GroupLocalProvider._internal();

	Future<Group> addGroup(Group group) async {
		return await GroupDB().addGroup(group);
	}

	Future<int> updateGroup(Group group) async {
		return await GroupDB().updateGroup(group);
	}

	Future<int> deleteGroup(int key) async {
		return await GroupDB().deleteGroup(key);
	}

	Future<Group> getGroupById(int id) async {
		return await GroupDB().getGroupById(id);
	}
}