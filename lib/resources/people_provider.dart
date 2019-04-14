import 'dart:async';
import '../models/PeopleModel.dart';

/* Get people */
import 'masterDb.dart';

class PeopleProvider {
  Future<List<People>> retrievePeople() async => masterDatabase.getAllPeopleFromDB();

  Future<List<People>> fetchPeople() async {
    return await retrievePeople();
  }

  Future<People> addPeople (String name, String surname, String shortBio, int section) async {
    final people = await masterDatabase.addPeopleToDB(name, surname, shortBio, section);
    return people;
  }

  Future<void> deletePeople(People item) async {
    await masterDatabase.deletePersonFromDB(item);
  }

  Future<bool> updatePeople(People item) async {
    return await masterDatabase.updatePeopleToDB(item);
  }
}
