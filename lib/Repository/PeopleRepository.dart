import '../models/PeopleModel.dart';
import '../Provider/PeopleProvider.dart';

class PeopleRepository {
  PeopleRepository();

  Future<People> addPerson(People person) async {
    return await PeopleLocalProvider().add(person);
  }

  Future<bool> deletePerson(People item) async {
    return await PeopleLocalProvider().delete(item.id);
  }

  Future<People> getPersonById(int id) async {
    return await PeopleLocalProvider().retrieveById(id);
  }

  Future<List<People>> getAllPeopleBy({List<int> id, int group, int section}) async {
    return await PeopleLocalProvider().retrieveAll(groupId: group, sectionId: section, id: id);
  }

  Future<People> updatePeople(People person) async {
    final result = await PeopleLocalProvider().update(person);
    if(result > 0) return person;
    return null;
  }

  Future<int> getPeopleSection(int id) async {
    final people = await getPersonById(id);
    if(people == null) return -1;
    return people.section;
  }

  Future<int> getPeopleGroup(int id) async {
    final people = await getPersonById(id);
    if(people == null) return -1;
    return people.group;
  }
}
