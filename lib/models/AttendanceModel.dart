class Attendance {
  int id;
  bool attendant;

  /* Foreign keys */
  int peopleID;
  int shiftID;
  int sectionID;
  int groupID;

  Attendance(this.attendant, this.peopleID, this.shiftID, this.groupID,
      [this.id, this.sectionID]);

  factory Attendance.fromMap(Map<String, dynamic> params) {
    return Attendance(
        (params['attendant'] == 1) ? true : false,
        params['personid'],
        params['shiftID'],
        params['id'],
        params['section'],
        params['group']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'attendance': (this.attendant == true) ? 1 : 0,
      'personid': this.peopleID,
      'shiftid': this.shiftID,
      'id': this.id,
      'sectionid': this.sectionID,
      'groupid': this.groupID
    };
  }
}
