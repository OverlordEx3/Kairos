
class Group {
	int id;
	String name;

	Group(this.name, [this.id]);

	factory Group.fromMap(Map<String, dynamic> params) {
		return Group(params['name'], params['id']);
	}

	Map<String, dynamic> toMap() {
		return <String, dynamic> {
			'name' : this.name,
			'id' : this.id
		};
	}
}