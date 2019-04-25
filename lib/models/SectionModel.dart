
class Section {
	int id;
	String name;
	int color;

	/* Foreign key */
	int groupID;

	Section(this.name, this.id, [this.color, this.groupID]);

	factory Section.fromMap(Map<String, dynamic> params) {
		return Section(params['sectionname'], params['id'], params['color'], params['groupid']);
	}

	Map<String, dynamic> toMap() {
		return <String, dynamic> {
			'sectionname' : this.name,
			'id' : this.id,
			'color' : this.color,
			'groupid' : this.groupID
		};
	}
}
