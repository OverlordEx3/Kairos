
enum ShiftStatus {
	///Shift has an error
  SHIFT_ERROR,
	/// Shift is recently created and empty
  SHIFT_NEW,
	/// Shift is filled with data and ready to be closed (and saved)
  SHIFT_OPEN,
	/// Shift is closed and read-only.
  SHIFT_CLOSED,
	/// Shift was re-opened and filled with different data
  SHIFT_EDITED
}

class Shift {
  int uid;
  int date;
  ShiftStatus status;

  Shift({this.uid, this.date, this.status});

/* Constructors*/
  factory Shift.fromMap(Map<String, dynamic> parsedJson) {
    return Shift(
      uid: parsedJson['uid'],
      date: parsedJson['date'],
      status: ShiftStatus.values[parsedJson['status']]
    );
  }

  Map<String, dynamic> toMap(){
    return <String, dynamic> {
      'uid' : this.uid,
      'date' : this.date,
      'status' : this.status.index
    };
  }
}