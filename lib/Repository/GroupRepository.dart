import '../models/GroupModel.dart';


class GroupRepository {
	Group currentGroup;

	Future<Group> addGroup(Group group) async {
		return Group('');
	}

	Future<Group> updateGroup(Group group) async {
		return group;
	}

	Future<bool> removeGroup(Group group) async {
		return false;
	}

	Future<Group> getGroupById(int id) async {

		return Group('', id);
	}

	String get groupName => currentGroup != null ? currentGroup.name : '';
	int get groupId => currentGroup != null ? currentGroup.id : -1;
}