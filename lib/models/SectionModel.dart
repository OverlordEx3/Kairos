
class _SectionModel {
	int id;
	String name;
	int color;

	/* Foreign key */
	int groupID;

	_SectionModel(this.name, this.id, [this.color, this.groupID]);

	factory _SectionModel.fromMap(Map<String, dynamic> params) {
		return _SectionModel(params['name'], params['id'], params['color'], params['group']);
	}

	Map<String, dynamic> toMap() {
		return <String, dynamic> {
			'name' : this.name,
			'id' : this.id,
			'color' : this.color,
			'group' : this.groupID
		};
	}
}

class Section extends _SectionModel {
	Section(String name, int id, [int color, int groupID]) : super(name, id, color, groupID);
}