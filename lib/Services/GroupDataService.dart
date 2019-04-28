import '../models/GroupModel.dart' show Group;

class GroupDataService {
	final Group _group;

	GroupDataService(this._group);

	/* Getters */
	String get groupName => _group.name;
	int get groupID => _group.id;

	/* Setters */
	bool updateGroupName(String name) {
		if(name != groupName) {
			_group.name = name;
			/* Update succeeded */
			return true;
		}
		return false;
	}
}