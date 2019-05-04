import '../models/AttendanceModel.dart' show Attendance;
import '../Provider/IProvider.dart' show IProvider;

class AttendanceRepository {
  final IProvider<Attendance> provider;

  AttendanceRepository({this.provider});

  Future<Attendance> add({Map<String, dynamic> params}) {
    return provider.add(params);
  }

  Future<bool> delete(int key, Attendance item) {
    return provider.delete(key);
  }

  Future<Attendance> get({Map<String, dynamic> whereArgs}) {
    return provider.retrieve(whereArgs: whereArgs);
  }

  Future<List<Attendance>> getAll({Map<String, dynamic> whereArgs}) {
    return provider.retrieveAll(whereArgs: whereArgs);
  }

  Future<Attendance> update(int key,
      {Map<String, dynamic> params, Map<String, dynamic> whereArgs}) async {
  }
}
