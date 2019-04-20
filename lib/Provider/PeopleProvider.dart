import 'dart:async' show Future;
import 'package:count_me_in/Provider/IProvider.dart' show IProvider, IProviderLocation;
import '../models/PeopleModel.dart' show People;

/* Get people */
import '../resources/masterDb.dart' show masterDatabase;

class PeopleLocalProvider implements IProvider<People> {
  IProviderLocation get location => IProviderLocation.local;

  @override
  Future<People> add(Map<String, dynamic> params) async{
    final item = masterDatabase.addPeopleToDB(params['name'], params['surname'], params['shortBio'], params['section']);
    return await item;
  }

  @override
  Future<bool> delete(int key) async {
    final result = await masterDatabase.deletePersonFromDB(key);
    if(result > 0) return true;
    return false;
  }

  @override
  Future<void> executeNonQuery(String query) {
    // TODO: implement executeNonQuery
    return null;
  }

  @override
  Future<List<People>> executeQuery(String query) {
    // TODO: implement executeQuery
    return null;
  }

  @override
  Future<People> retrieve({Map<String, dynamic> whereArgs}) {
    // TODO: implement retrieve
    return null;
  }

  @override
  Future<List<People>> retrieveAll({Map<String, dynamic> whereArgs}) async {
    return masterDatabase.getAllPeopleFromDB();
  }

  @override
  Future<int> update(People item, {Map<String, dynamic> whereArgs}) async{
    return await masterDatabase.updatePeopleToDB(item);
  }
}

class PeopleRemoteProvider implements IProvider<People> {
  @override
  // TODO: implement location
  IProviderLocation get location => IProviderLocation.remote;

  @override
  Future<People> add(Map<String, dynamic> params) {
    // TODO: implement add
    return null;
  }

  @override
  Future<bool> delete(int key) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<void> executeNonQuery(String query) {
    // TODO: implement executeNonQuery
    return null;
  }

  @override
  Future<List<People>> executeQuery(String query) {
    // TODO: implement executeQuery
    return null;
  }

  @override
  Future<People> retrieve({Map<String, dynamic> whereArgs}) {
    // TODO: implement retrieve
    return null;
  }

  @override
  Future<List<People>> retrieveAll({Map<String, dynamic> whereArgs}) {
    // TODO: implement retrieveAll
    return null;
  }

  @override
  Future<int> update(People item, {Map<String, dynamic> whereArgs}) {
    // TODO: implement update
    return null;
  }

}
