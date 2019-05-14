import 'dart:async' show Future;
import '../models/PeopleModel.dart' show People;

/* Get people */
import '../resources/LocalDatabase/PeopleDB.dart';

class PeopleLocalProvider {
  static final _instance = PeopleLocalProvider._internal();
  factory PeopleLocalProvider() => _instance;
  PeopleLocalProvider._internal();

  Future<People> add(People person) async{
    final item = PeopleDB().addPerson(person);
    return await item;
  }

  Future<bool> delete(int key) async {
    final result = await PeopleDB().deletePerson(key);
    if(result > 0) return true;
    return false;
  }

  Future<People> retrieveById(int id) {
    return PeopleDB().getPersonById(id);
  }

  Future<List<People>> retrieveAll({int groupId, int sectionId, List<int> id}) async {
    return PeopleDB().getPeopleBy(groupId: groupId, sectionId: sectionId, id: id);
  }

  Future<int> update(People item) async{
    return await PeopleDB().updatePerson(item);
  }
}
