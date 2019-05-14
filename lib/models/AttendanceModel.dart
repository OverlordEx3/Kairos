class Attendance {
  int id;
  bool attendant;

  /* Foreign keys */
  int personId;
  int shiftId;
  int sectionId;
  int groupId;

  Attendance(this.attendant, this.personId, this.shiftId, this.groupId,
      {this.id, this.sectionId});

  factory Attendance.fromMap(Map<String, dynamic> params) {
    return Attendance(
        (params['attendance'] == 1) ? true : false,
        params['personid'],
        params['shiftid'],
        params['groupid'],
        id: params['id'],
        sectionId : params['sectionid']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'attendance': (this.attendant == true) ? 1 : 0,
      'personid': this.personId,
      'shiftid': this.shiftId,
      'id': this.id,
      'sectionid': this.sectionId,
      'groupid': this.groupId
    };
  }
}
