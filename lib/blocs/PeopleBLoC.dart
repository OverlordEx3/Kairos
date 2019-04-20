import 'package:rxdart/rxdart.dart';

import '../models/PeopleModel.dart' show People;
import 'package:count_me_in/Repository/PeopleRepository.dart' show PeopleRepository;
import '../Repository/PeopleCache.dart' show PeopleHashCache;
import '../Provider/PeopleProvider.dart' show PeopleLocalProvider;

final PeopleBloc peopleBloc = PeopleBloc();

class PeopleBloc {
  /* Repository, handling internally all data from services (web/local) */
  final _repository = PeopleRepository(cache: PeopleHashCache(), provider: PeopleLocalProvider());

  /* Stream Controller, used to handle in/out data to the repository */
  final _peopleFetchController = new PublishSubject<List<People>>();
  /* Getter method to retrieve all people from stream. Stream list
   * to know when some child of it changed. Or received.
   * It's, primarily, a Subscriber*/
  Stream<List<People>> get peopleStream => _peopleFetchController.stream;
  Sink<List<People>> get _inPeopleSink => _peopleFetchController.sink;

  final _peopleAddController = new PublishSubject<Map<String, dynamic>>();
  Sink<Map<String, dynamic>> get _addPeople => _peopleAddController.sink;
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
  void _handleRemovePeople(People key) async {
    _repository.delete(key.hashCode, key).then((value) {
      retrieveAll();
    });
  }

  void _handleAddPeople(Map<String, dynamic> params) async {
    _repository.add(params: params).then((value) async {
      retrieveAll();
    });
  }

  void _handleUpdatePeople(People item) async {
    _repository.update(item.hashCode, params: {
      'uid' : item.uid,
      'name' : item.name,
      'surname' : item.surname,
      'shortbio' : item.shortBio,
      'section' : item.sectionID
    }).then((value) async {
      retrieveAll();
    });
  }

  void _notify(value) async {
    _inPeopleSink.add(value);
  }

  /* PUBLIC METHODS */
  dispose() async {
    await _peopleFetchController?.drain()?.whenComplete(() => _peopleFetchController?.close());
    await _peopleAddController?.drain()?.whenComplete(() => _peopleAddController?.close());
    await _peopleRemoveController?.drain()?.whenComplete(() => _peopleRemoveController?.close());
    await _peopleUpdateController?.drain()?.whenComplete(() => _peopleUpdateController?.close());
  }

  retrieveAll() async {
    _repository.getAll().then((value) => _notify(value));
  }

  submitNew([String name, String surname, String shortBio, int sectionID]) async {
    _addPeople.add({
      'name' : name,
      'surname' : surname,
      'shortbio' : shortBio,
      'section' : sectionID
    });
  }

  delete(People item) async {
    _removePeople.add(item);
  }

  update(People item) async {
    _updatePeople.add(item);
  }
}
