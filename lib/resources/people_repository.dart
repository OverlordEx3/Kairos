import '../models/people_model.dart';
import 'people_provider.dart';

class PeopleRepository {
  /* TODO add provider */
  final PeopleProvider _peopleProvider = PeopleProvider();

  /* TODO replace this mock*/

  Future<List<PeopleModel>> FetchAllPeople() => _peopleProvider.FetchPeople();
}
