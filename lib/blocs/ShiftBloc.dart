import 'package:rxdart/rxdart.dart';
import 'dart:async';

/* Models */
import '../models/ShiftModel.dart' show Shift, ShiftStatus;
import '../models/AttendanceModel.dart' show Attendance;

import '../Provider/ShiftProvider.dart' show ShiftLocalProvider;
import '../Provider/AttendanceProvider.dart' show AttendanceProvider;
import '../Repository/AttendanceRepository.dart' show AttendanceRepository;
import 'package:count_me_in/Repository/ShiftRepository.dart';

final ShiftBloc shiftBloc = ShiftBloc();

class ShiftBloc {
  /* Control streams */
  final _shiftFetchController = new PublishSubject<ShiftStatus>();
  Stream<ShiftStatus> get shiftStatusStream => _shiftFetchController.stream;
  Function(ShiftStatus) get _shiftStatusSink => _shiftFetchController.sink.add;

  final _shiftAttendanceController = new PublishSubject<Map<int, bool>>();
  Stream<Map<int, bool>> get _shiftAttendanceStream =>
      _shiftAttendanceController.stream;
  Function(Map<int, bool>) get _shiftAttendanceAddItem =>
      _shiftAttendanceController.sink.add;

  ShiftBloc() {
  	_shiftAttendanceStream?.listen(_handleShiftAttendanceAdd);
  }

  dispose() async {
  	_shiftAttendanceController?.drain()?.whenComplete(() => _shiftAttendanceController?.close());
  	_shiftFetchController?.drain()?.whenComplete(()=> _shiftFetchController?.close());
  }

  void _handleShiftAttendanceAdd(Map<int, bool> params) {

  }

  requestNewShift() async {

  }

  /* Map <int, bool> = map PeopleID with attendance true/false */
  closeShift() async {

  }

  cancelShift() async {

  }

  setAttendant(int id, bool attendant) {

  }
}
