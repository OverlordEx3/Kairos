import 'dart:async';
/* Models */
import '../models/ShiftModel.dart';
import '../models/AttendanceModel.dart';

import '../Provider/ShiftAttendanceProvider.dart';

class ShiftAttendanceRepository {
  Set<Attendance> _attendant = Set<Attendance>();
  Shift currentShift;
  bool isShiftActive = false;

  Future<Shift> createNewShift(ShiftStatus status) async {
    final shift = Shift(status: status, date: DateTime.now());
    /* Provider  */
    currentShift = await ShiftAttendanceLocalProvider().addShift(shift);
    return currentShift;
  }

  Future<Shift> updateShift(ShiftStatus status) async {
    currentShift.status = status;
    /* Provider */
    ShiftAttendanceLocalProvider().updateShift(currentShift);
    return currentShift;
  }

  Future<bool> removeShift() async {
    /* Ask provider */
    if(currentShift == null) return false;
    final result = await ShiftAttendanceLocalProvider().deleteShift(currentShiftId);
    if(result == true) currentShift = null;
    return result;
  }

  Future<List<Shift>> getShiftsBy({List<int> id, int section, int group}) async {
    return ShiftAttendanceLocalProvider().retrieveAllShiftsBy(id: id, sectionId: section, groupId: group);
  }

  void setCurrentAttendanceItem(int personId, bool attendance, int group, {int section}) {
    if (attendance == true) {
      _attendant.add(Attendance(true, personId, this.currentShiftId, group, sectionId: section));
    } else {
      _attendant.removeWhere((att) => att.personId == personId);
    }
  }

  bool getCurrentAttendanceItem(int id) {
    return false;
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
    if(_attendant == null) return <Attendance>[];
    ShiftAttendanceLocalProvider().addAttendanceListItems(_attendant.toList());
    return <Attendance>[];
  }

  Future<List<Attendance>> updateAttendanceList() async {
    return <Attendance>[];
  }

  Future<List<Attendance>> getAttendanceBy({List<int> id, int shift, int section, int group, int personId}) async {
    return await ShiftAttendanceLocalProvider().getAttendanceListBy(sectionId: section, groupId: group, shiftId: shift, personId: personId, id: id);
  }

  /* getters */
  int get currentShiftId {
    if (currentShift == null) {
      return -1;
    }
    return currentShift.id;
  }
}
