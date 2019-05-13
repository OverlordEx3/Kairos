import 'dart:async';
/* Model */
import '../models/ShiftModel.dart';
import '../models/AttendanceModel.dart';
import '../resources/LocalDatabase/ShiftAttendanceDB.dart';

class ShiftAttendanceLocalProvider {
  static final _instance = ShiftAttendanceLocalProvider._internal();
  factory ShiftAttendanceLocalProvider() => _instance;
  ShiftAttendanceLocalProvider._internal();

  Future<Shift> addShift(Shift shift) async {
  	return await ShiftAttendanceDB().addShift(shift);
  }

  Future<bool> deleteShift(int key) async {
  	final result = await ShiftAttendanceDB().deleteShift(key);
    if(result > 0) return true;
    return false;
  }

  Future<List<Shift>> retrieveAllShiftsBy({int groupId, int sectionId, List<int> id}) async {
    return await ShiftAttendanceDB().getShiftsBy(groupId: groupId, sectionId: sectionId, id: id);
  }

  Future<Shift> retrieveShiftById(int id) async {
  	var _shift;
  	ShiftAttendanceDB().getShiftsBy(id: [id]).then((shift) => _shift = shift);
  	return _shift;
  }

  Future<int> updateShift(Shift item) async {
    return await ShiftAttendanceDB().updateShift(item);
  }

  Future<Attendance> addAttendance(Attendance item) async {
  	return await ShiftAttendanceDB().addAttendanceItem(item);
  }

  Future<List<Attendance>> addAttendanceListItems(List<Attendance> items) async {
	  return await ShiftAttendanceDB().addListAttendanceItems(items);
  }

  Future<int> deleteAttendanceItem(int key) async {
  	return await ShiftAttendanceDB().deleteShift(key);
  }

  Future<int> updateAttendance(Attendance item) async {
  	return await ShiftAttendanceDB().updateAttendanceItem(item);
  }

  Future<List<Attendance>> getAttendanceListBy({int sectionId, int groupId, int personId, int shiftId, List<int> id}) async {
  	return await ShiftAttendanceDB().getAttendanceBy(id: id, sectionId: sectionId, groupId: groupId, personId: personId, shiftId: shiftId);
	}
}