import '../models/ShiftModel.dart';
import 'IProvider.dart' show IProvider, IProviderLocation;
import '../resources/database/ShiftDB.dart' show shiftDB;

class ShiftLocalProvider implements IProvider<Shift> {
  IProviderLocation get location => IProviderLocation.local;

  @override
  Future<Shift> add(Map<String, dynamic> params) async {
    return await shiftDB.addShift(params['date'], params['status']);
  }

  @override
  Future<bool> delete(int key) async {
    final result = await shiftDB.deleteShift(key);
    if(result > 0) return true;
    return false;
  }

  @override
  Future<void> executeNonQuery(String query) {
    // TODO: implement executeNonQuery
    return null;
  }

  @override
  Future<List<Shift>> executeQuery(String query) {
    // TODO: implement executeQuery
    return null;
  }

  @override
  Future<Shift> retrieve({Map<String, dynamic> whereArgs}) {
    // TODO: implement retrieve
    return null;
  }

  @override
  Future<List<Shift>> retrieveAll({Map<String, dynamic> whereArgs}) async {
    return await shiftDB.getAllShifts();
  }

  @override
  Future<int> update(Shift item, {Map<String, dynamic> whereArgs}) async {
    return await shiftDB.updateShift(item);
  }
}