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
  /* Keep track of the last shift. If one is active, of course */
  bool shiftActive = false;
  Shift _currentShiftHandle;
  Map<int, bool> _currentAttendanceList = Map<int, bool>();

  final initialStatus = ShiftStatus.SHIFT_ERROR;

  /* Repositories */
  final _shiftRepository = ShiftRepository(provider: ShiftLocalProvider());
  final _attendanceRepository =
      AttendanceRepository(provider: AttendanceProvider());

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
    _currentAttendanceList[params.keys.first] = params.values.first;
  }

  requestNewShift() async {
    if (shiftActive != true) {
      shiftActive = true;
      _shiftRepository.add(params: {
        'date': DateTime.now().millisecondsSinceEpoch,
        'status': ShiftStatus.SHIFT_NEW.index
      }).then((shift) {
        _currentShiftHandle = shift;
        _shiftStatusSink(_currentShiftHandle.status);
      });
    }
  }

  /* Map <int, bool> = map PeopleID with attendance true/false */
  closeShift() async {
    if (shiftActive != true) {
      print("Requested shift close on a inactive shift!");
      return;
    }

    _currentAttendanceList.forEach((id, att) async {
      var attendance = Attendance(att, id, _currentShiftHandle.uid);
      _attendanceRepository.add(params: attendance.toMap());
    });

    /* Finally, close shift */
    _currentShiftHandle.status = ShiftStatus.SHIFT_CLOSED;
    _shiftRepository
        .update(_currentShiftHandle.hashCode,
            params: _currentShiftHandle.toMap())
        .then((shift) {
      _currentShiftHandle = null;
      shiftActive = false;
    });

    _shiftStatusSink(ShiftStatus.SHIFT_ERROR);
  }

  cancelShift() async {
    if (shiftActive != true) {
      print("Requested shift cancel on a inactive shift!");
      return;
    }
    _currentAttendanceList.clear();
    _currentShiftHandle = null;
    shiftActive = false;
  }

  setAttendant(int id, bool attendant) {
  	_shiftAttendanceAddItem({id : attendant});
  }
}
