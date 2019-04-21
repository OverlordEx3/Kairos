import '../models/ShiftModel.dart';
import 'IRepository.dart' show IRepository;
import '../Provider/IProvider.dart' show IProvider;

class ShiftRepository implements IRepository<Shift> {
  final IProvider<Shift> provider;

  ShiftRepository({this.provider});

  @override
  Future<Shift> add({Map<String, dynamic> params}) {
    return provider.add(params);
  }

  @override
  Future<bool> delete(int key, Shift item) {
    return provider.delete(key);
  }

  @override
  Future<Shift> get({Map<String, dynamic> whereArgs}) {
    return provider.retrieve(whereArgs: whereArgs);
  }

  @override
  Future<List<Shift>> getAll({Map<String, dynamic> whereArgs}) {
    return provider.retrieveAll();
  }

  @override
  Future<Shift> update(int key, {Map<String, dynamic> params, Map<String, dynamic> whereArgs}) async {
    final shift = Shift(uid: params['uid'], status: params['status'], date: params['date']);
    await provider.update(shift);
    return null;
  }
}