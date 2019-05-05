import '../models/PeopleModel.dart';

class PeopleRepository {

  PeopleRepository();

  Future<People> addPerson(People person) async {

    return person;
  }

  Future<bool> deletePerson(People item) async {

    return false;
  }

  Future<People> getPersonById(int id) async {

    return People('', '', -1);
  }

  Future<List<People>> getAllPeopleBy({List<int> id, int group, int section}) async {

    return <People>[];
  }

  Future<People> updatePeople(People person) async {

    return People('', '', -1);
  }

  int getPeopleSection(int id) {
    /* TODO fetch and return */
    return -1;
  }

  int getPeopleGroup(int id) {
    /* TODO fetch and return */
    return -1;
  }
}
