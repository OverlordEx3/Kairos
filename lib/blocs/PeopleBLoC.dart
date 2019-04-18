import 'package:rxdart/rxdart.dart';

import '../models/PeopleModel.dart' show People;
import '../resources/PeopleRepository.dart' show PeopleRepository;

final PeopleBloc peopleBloc = PeopleBloc();

class PeopleBloc {
  /* People cache */
  List<People> _people = new List<People>();

  /* Repository, handling internally all data from services (web/local) */
  final _repository = PeopleRepository();

  /* Stream Controller, used to handle in/out data to the repository */
  final _peopleFetchController = new ReplaySubject<List<People>>();
  /* Getter method to retrieve all people from stream. Stream list
   * to know when some child of it changed. Or received.
   * It's, primarily, a Subscriber*/
  Stream<List<People>> get peopleStream => _peopleFetchController.stream;
  Sink<List<People>> get _inPeopleSink => _peopleFetchController.sink;

  final _peopleAddController = new PublishSubject<People>();
  Sink<People> get _addPeople => _peopleAddController.sink;
  final _peopleRemoveController = new PublishSubject<People>();
  Sink<People> get _removePeople => _peopleRemoveController.sink;
  final _peopleUpdateController = new PublishSubject<People>();
  Sink<People> get _updatePeople => _peopleUpdateController.sink;


  /* Constructor */
  PeopleBloc() {
    _peopleAddController?.listen(_handleAddPeople);
    _peopleRemoveController?.listen(_handleRemovePeople);
    _peopleUpdateController?.listen(_handleUpdatePeople);
  }

  /* Private controller listener. All magic is done here */
  void _handleRemovePeople(People item) async {
    _repository.deletePeople(item);
    _people.remove(item);
    _notify();
  }

  void _handleAddPeople(People item) async {
    final newPerson = await _repository.addPeople(item.name, item.surname, item.shortBio, item.sectionID);

    /* Add to people list, based on item returned by repository's add people call. */
    _people.add(newPerson);
    _notify();
  }

  void _handleUpdatePeople(People item) async {
	  await _repository.updatePeople(item);

	  _people.clear();
	  _people.addAll(await _repository.fetchAllPeople());
	  _notify();
  }

  void _notify() async {
    _inPeopleSink.add(_people);
  }

  /* PUBLIC METHODS */
  dispose() async {
    _people.clear();
    await _peopleFetchController?.drain()?.whenComplete(() => _peopleFetchController?.close());
    await _peopleAddController?.drain()?.whenComplete(() => _peopleAddController?.close());
    await _peopleRemoveController?.drain()?.whenComplete(() => _peopleRemoveController?.close());
    await _peopleUpdateController?.drain()?.whenComplete(() => _peopleUpdateController?.close());
  }

  fetchAllPeople() async {
    _people.clear();
    _people.addAll(await _repository.fetchAllPeople());
    _notify();
  }

  submitNewPeople(String name, String surname, String shortBio, int sectionID) async {
    final peopleItem = new People(name: name, surname: surname, shortBio: shortBio, sectionID: sectionID);
    _addPeople.add(peopleItem);
  }

  deletePeople(People item) async {
    _removePeople.add(item);
  }

  updatePeople(People item) async {
    _updatePeople.add(item);
  }

}
