import 'dart:async';
/* Models */
import '../models/ShiftModel.dart';
import '../models/AttendanceModel.dart';

class ShiftAttendanceRepository {
  Set<int> _attendant = Set<int>();
  Shift currentShift;
  bool isShiftActive = false;

  Future<Shift> createNewShift(ShiftStatus status) async {
    final shift = Shift(status: status, date: DateTime.now());
    /* Provider  */

    return shift;
  }

  Future<Shift> updateShift(ShiftStatus status) async {
    currentShift.status = status;
    /* Provider */
    return currentShift;
  }

  Future<bool> removeShift(int id) async {
    /* Ask provider */
    return false;
  }

  Future<List<Shift>> getShiftsBy({int id, int section, int group}) async {
    return <Shift>[];
  }

  void setCurrentAttendanceItem(int id, bool attendance) {
    if (attendance == true) {
      _attendant.add(id);
    } else {
      _attendant.removeWhere((attId) => attId == id);
    }
  }

  bool getCurrentAttendanceItem(int id) {
    return _attendant.contains(id);
  }

  Future<Attendance> addAttendance() async {
    return Attendance(false, -1, -1, -1);
  }

  Future<Attendance> updateAttendance(Attendance item) async {
    return item;
  }

  Future<bool> removeAttendance(Attendance item) async {
    return false;
  }

  Future<List<Attendance>> saveAttendanceList() async {
    return <Attendance>[];
  }

  Future<List<Attendance>> updateAttendanceList() async {
    return <Attendance>[];
  }

  Future<List<Attendance>> getAttendanceBy({int id, int shift, int section, int group}) async {
    return <Attendance>[];
  }

  /* getters */
  int get currentShiftId {
    if (currentShift == null) {
      return -1;
    }
    return currentShift.id;
  }
}
