
class Section {
	int id;
	String name;
	int color;

	/* Foreign key */
	int groupId;

	Section(this.name, this.groupId, {this.color, this.id});

	factory Section.fromMap(Map<String, dynamic> params) {
		return Section(params['name'], params['groupid'], id: params['id'], color: params['color']);
	}

	Map<String, dynamic> toMap() {
		return <String, dynamic> {
			'name' : this.name,
			'id' : this.id,
			'color' : this.color,
			'groupid' : this.groupId
		};
	}
}
