import 'package:rxdart/rxdart.dart';

import '../models/people_model.dart';
import '../resources/PeopleRepository.dart';

final PeopleBloc peopleBloc = PeopleBloc();

class PeopleBloc {
  /* Repository, handling internally all data from services (web/local) */
  final _repository = PeopleRepository();

  /* Stream Controller, used to handle in/out data to the repository */
  final _peopleFetcher = new PublishSubject<List<PeopleModel>>();

  /* Getter method to retrieve all people from stream. Observable list
   * to know when some child of it changed. Or received.
   * It's, primarily, a Subscriber*/
  Observable<List<PeopleModel>> get AllPeople => _peopleFetcher.stream;

  fetchAllPeople() async {
    _peopleFetcher.sink.add(await _repository.FetchAllPeople());
  }

  submitNewPeople(String name, String surname, String shortbio, int ID) async {
    _repository.AddPeople(name, surname, ID, shortbio);
    await _peopleFetcher.stream.drain();
    _peopleFetcher.sink.add(await _repository.FetchAllPeople());
  }

  deletePeople(PeopleModel item) async {
    _repository.DeletePeople(item);
    await _peopleFetcher.stream.drain();
    _peopleFetcher.sink.add(await _repository.FetchAllPeople());
  }

  dispose() async {
    await _peopleFetcher.drain();
    _peopleFetcher.close();
  }

}
