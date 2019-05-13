import '../models/GroupModel.dart';
import '../Provider/GroupProvider.dart';


class GroupRepository {
	Group currentGroup;

	Future<Group> addGroup(Group group) async {
		return GroupLocalProvider().addGroup(group);
	}

	Future<Group> updateGroup(Group group) async {
		final result = await GroupLocalProvider().updateGroup(group);
		if(result > 0) return group;
		return null;
	}

	Future<bool> removeGroup(Group group) async {
		final result = await GroupLocalProvider().deleteGroup(group.id);
		if(result > 0)  return true;
		return false;
	}

	Future<Group> getGroupById(int id) async {
		return await GroupLocalProvider().getGroupById(id);
	}

	String get groupName => currentGroup != null ? currentGroup.name : '';
	int get groupId => currentGroup != null ? currentGroup.id : -1;
}