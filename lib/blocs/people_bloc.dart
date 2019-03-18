import 'package:rxdart/rxdart.dart';

import '../models/people_model.dart';
import '../resources/people_repository.dart';

final PeopleBloc bloc = PeopleBloc();

class PeopleBloc {
  final _repository = PeopleRepository();
  final _peopleFetcher = new PublishSubject<PeopleModel>();

  /* Getter method to retrieve all people from stream. Observable list
   * to know when some child of it changed. Or received */
  Observable<PeopleModel> get AllPeople => _peopleFetcher.stream;

  fetchAllPeople() async {
    PeopleModel peopleModel = await _repository.FetchAllPeople();
    _peopleFetcher.sink.add(peopleModel);
  }

  dispose() {
    _peopleFetcher.close();
  }

}
