import 'package:rxdart/rxdart.dart';

import '../models/people_model.dart';
import '../resources/people_repository.dart';

final PeopleBloc peopleBloc = PeopleBloc();

class PeopleBloc {
  final _repository = PeopleRepository();
  final _peopleFetcher = new PublishSubject<List<PeopleModel>>();

  /* Getter method to retrieve all people from stream. Observable list
   * to know when some child of it changed. Or received */
  Observable<List<PeopleModel>> get AllPeople => _peopleFetcher.stream;

  fetchAllPeople() async {
    List<PeopleModel> peopleModel = await _repository.FetchAllPeople();
    _peopleFetcher.sink.add(peopleModel);
  }

  submitNewPeople(String name, String surname, DateTime birthdate, String shortbio, int ID ,{int uid, int hash}) async {

  }


  dispose() {
    _peopleFetcher.drain();
    _peopleFetcher.close();
  }

}
