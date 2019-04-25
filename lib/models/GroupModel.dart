
class Group {
	int id;
	String name;

	Group(this.name, [this.id]);

	factory Group.fromMap(Map<String, dynamic> params) {
		return Group(params['groupname'], params['id']);
	}

	Map<String, dynamic> toMap() {
		return <String, dynamic> {
			'groupname' : this.name,
			'id' : this.id
		};
	}
}