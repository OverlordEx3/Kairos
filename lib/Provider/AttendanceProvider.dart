import '../models/AttendanceModel.dart' show Attendance;
import 'IProvider.dart' show IProvider,IProviderLocation;
import '../resources/database/AttendanceDB.dart' show attendanceDB;

class AttendanceProvider implements IProvider<Attendance> {
	@override
	IProviderLocation get location => IProviderLocation.local;

  @override
  Future<Attendance> add(Map<String, dynamic> params) {
    return attendanceDB.addAttendanceItem(params['attendant'], params['personid'], params['shiftID']);
  }

  @override
  Future<bool> delete(int key) async {
  	var count = await attendanceDB.deleteAttendanceItem(key);
  	if(count > 0) return true;
  	return false;
  }

  @override
  Future<void> executeNonQuery(String query) {
    // TODO: implement executeNonQuery
    return null;
  }

  @override
  Future<List<Attendance>> executeQuery(String query) {
    // TODO: implement executeQuery
    return null;
  }

  @override
  Future<Attendance> retrieve({Map<String, dynamic> whereArgs}) {
    if(whereArgs.containsKey('id')) {
    	return attendanceDB.getAttendanceItem(whereArgs['id']);
    }
    return null;
  }

  @override
  Future<List<Attendance>> retrieveAll({Map<String, dynamic> whereArgs}) async {
  	if(whereArgs.containsKey('shiftid')) {
  		return attendanceDB.getAttendanceByShift(whereArgs['shiftid']);
	  } else if(whereArgs.containsKey('personid')) {
  		return attendanceDB.getAttendanceByPerson(whereArgs['personid']);
	  }
    return <Attendance>[]; //Because reasons
  }

  @override
  Future<int> update(Attendance item, {Map<String, dynamic> whereArgs}) {
	  return attendanceDB.updateAttendanceItem(item);
  }
}
