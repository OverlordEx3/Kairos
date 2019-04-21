import '../models/AttendanceModel.dart' show Attendance;
import 'IRepository.dart' show IRepository;
import '../Provider/IProvider.dart' show IProvider;

class AttendanceRepository implements IRepository<Attendance> {
  final IProvider<Attendance> provider;

  AttendanceRepository({this.provider});

  @override
  Future<Attendance> add({Map<String, dynamic> params}) {
    return provider.add(params);
  }

  @override
  Future<bool> delete(int key, Attendance item) {
    return provider.delete(key);
  }

  @override
  Future<Attendance> get({Map<String, dynamic> whereArgs}) {
    return provider.retrieve(whereArgs: whereArgs);
  }

  @override
  Future<List<Attendance>> getAll({Map<String, dynamic> whereArgs}) {
    return provider.retrieveAll(whereArgs: whereArgs);
  }

  @override
  Future<Attendance> update(int key,
      {Map<String, dynamic> params, Map<String, dynamic> whereArgs}) async {
    final attendance = Attendance(params['attendant'], params['personid'],
        params['shiftID'], params['id'], params['section'], params['group']);
    provider.update(attendance, whereArgs: whereArgs);
    return attendance;
  }
}
