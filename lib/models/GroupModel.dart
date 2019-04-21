
class _GroupModel {
	int id;
	String name;

	_GroupModel(this.name, [this.id]);

	factory _GroupModel.fromMap(Map<String, dynamic> params) {
		return _GroupModel(params['name'], params['id']);
	}

	Map<String, dynamic> toMap() {
		return <String, dynamic> {
			'name' : this.name,
			'id' : this.id
		};
	}
}

class Group extends _GroupModel {
	Group(String name, [int id]) : super(name, id);
}