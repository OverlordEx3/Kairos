
class _AttendanceModel {
	int id;
	bool attendant;

	/* Foreign keys */
	int peopleID;
	int shiftID;
	int sectionID;
	int groupID;

	_AttendanceModel(this.attendant,this.peopleID, this.shiftID, [this.id, this.sectionID, this.groupID]);

	factory _AttendanceModel.fromMap(Map<String, dynamic> params) {
		return _AttendanceModel(params['attendant'], params['personid'], params['shiftID'], params['id'], params['section'], params['group']);
	}

	Map<String, dynamic> toMap() {
		return <String, dynamic>{
			'attendant': this.attendant,
			'personid' : this.peopleID,
			'shiftid' : this.shiftID,
			'id' : this.id,
			'section' : this.sectionID,
			'group' : this.groupID
		};
	}
}

class Attendance extends _AttendanceModel {
	Attendance(bool attendant,int peopleID, int shiftID, [int id, int sectionID, int groupID]) :
				super(attendant, peopleID, shiftID, id, sectionID, groupID);
}