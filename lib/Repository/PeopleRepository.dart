import '../models/PeopleModel.dart';
import 'package:count_me_in/common/ICache.dart' show ICache;

class PeopleRepository {
  final ICache<int, People> cache;

  PeopleRepository({this.cache});

  Future<People> add({Map<String, dynamic> params}) async {

  }

  Future<bool> delete(int key, People item) async {

  }

  Future<People> get({Map<String, dynamic> whereArgs}) async {

  }

  Future<List<People>> getAll({Map<String, dynamic> whereArgs}) async {

  }

  Future<People> update(int key,
      {Map<String, dynamic> params, Map<String, dynamic> whereArgs}) async {

  }
}
