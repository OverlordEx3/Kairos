import 'PeopleModel.dart';

enum ShiftStatus {
  SHIFT_ERROR,
  SHIFT_NEW,
  SHIFT_OPEN,
  SHIFT_CLOSED,
  SHIFT_EDITED
}

class ShiftModel {
  int _ID;
  DateTime _date;
  ShiftStatus _status;

  /* Getters */
  int get ID => _ID;
  DateTime get date => _date;
  ShiftStatus get shiftStatus => _status;

/* Constructors*/
  ShiftModel.fromJSON(Map<String, dynamic> parsedJson) {
    _ID = parsedJson['id'];
    _date = parsedJson['dt'];
    _status = parsedJson['st'];
    print("Shift model created OK!");
  }

  Map<String, dynamic> toJSON(){
    return <String, dynamic> {
      'id' : _ID,
      'dt' : _date,
      'st' : _status
    };
  }
}