import '../models/PeopleModel.dart';
import 'people_provider.dart';

class PeopleRepository {
  final PeopleProvider _peopleProvider = PeopleProvider();

  Future<List<People>> fetchAllPeople() => _peopleProvider.fetchPeople();

  Future<People> addPeople(String name, String surname, String shortBio, int section) => _peopleProvider.addPeople(name, surname, shortBio, section);
  Future<void> deletePeople(People item) => _peopleProvider.deletePeople(item);
  Future<bool> updatePeople(People item) => _peopleProvider.updatePeople(item);
}
