import '../models/PeopleModel.dart';
import 'people_provider.dart';

class PeopleRepository {
  final PeopleProvider _peopleProvider = PeopleProvider();

  Future<List<PeopleModel>> FetchAllPeople() => _peopleProvider.FetchPeople();

  Future<bool> AddPeople(String name, String surname, int docID, String shortbio) => _peopleProvider.AddPeople(name, surname, docID, shortbio);
  Future<void> DeletePeople(PeopleModel item) => _peopleProvider.DeletePeople(item);
  Future<bool> updatePeople(PeopleModel item) => _peopleProvider.updatePeople(item);
}
