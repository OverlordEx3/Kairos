
enum ShiftStatus {
	///Shift has an error
  error,
	/// Shift is recently created and empty
  empty,
	/// Shift is filled with data and ready to be closed (and saved)
  open,
	/// Shift is closed and read-only.
  closed,
	/// Shift was re-opened and filled with different data
  edited
}

class Shift {
  int id;
  DateTime date;
  ShiftStatus status;

  Shift({this.id, DateTime date, this.status});

/* Constructors*/
  factory Shift.fromMap(Map<String, dynamic> parsedJson) {
    return Shift(
        id: parsedJson['uid'],
        date: DateTime.fromMillisecondsSinceEpoch(parsedJson['date']),
        status: ShiftStatus.values[parsedJson['status']]
    );
  }

  Map<String, dynamic> toMap(){
    return <String, dynamic> {
      'uid' : this.id,
      'date' : this.date.millisecondsSinceEpoch,
      'status' : this.status.index
    };
  }
}