import 'people_model.dart';

enum ShiftStatus {
  SHIFT_NEW,
  SHIFT_OPEN,
  SHIFT_CLOSED,
  SHIFT_EDITED
}

class ShiftModel {
  int _ID;
  DateTime _date;
  int _status;

  /* Getters */
  int get ID => _ID;
  DateTime get date => _date;
  int get shiftStatus => _status;

/* Constructors*/
  ShiftModel.fromJSON(Map<String, dynamic> parsedJson) {
    _ID = parsedJson['id'];
    _date = parsedJson['dt'];
    _status = parsedJson['st'];
    print("Shift model created OK!");
  }

  ShiftModel.toJSON()
}