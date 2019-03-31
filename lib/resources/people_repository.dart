import '../models/people_model.dart';
import 'people_provider.dart';

class PeopleRepository {
  final PeopleProvider _peopleProvider = PeopleProvider();

  Future<List<PeopleModel>> FetchAllPeople() => _peopleProvider.FetchPeople();
}
