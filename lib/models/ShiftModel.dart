
enum ShiftStatus {
  SHIFT_ERROR,
  SHIFT_NEW,
  SHIFT_OPEN,
  SHIFT_CLOSED,
  SHIFT_EDITED
}

class _ShiftModel {
  int uid;
  int date;
  ShiftStatus status;

  _ShiftModel({this.uid, this.date, this.status});

/* Constructors*/
  factory _ShiftModel.fromJSON(Map<String, dynamic> parsedJson) {
    return _ShiftModel(
      uid: parsedJson['id'],
      date: parsedJson['dt'],
      status: parsedJson['st']
    );
  }

  Map<String, dynamic> toMap(){
    return <String, dynamic> {
      'id' : this.uid,
      'dt' : this.date,
      'st' : this.status
    };
  }
}

/* Aliasing */
class Shift extends _ShiftModel {
  Shift({int uid, int date, ShiftStatus status}) : super(uid: uid, date: date, status: status);
  factory Shift.fromJSON(Map<String, dynamic> json) => _ShiftModel.fromJSON(json);
  factory Shift.fromMap(Map<String, dynamic> params) => Shift.fromJSON(params);
}