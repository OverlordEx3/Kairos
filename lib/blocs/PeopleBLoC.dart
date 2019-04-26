import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../models/PeopleModel.dart' show People;
import 'package:count_me_in/Repository/PeopleRepository.dart' show PeopleRepository;
import '../Repository/PeopleCache.dart' show PeopleHashCache;
import '../Provider/PeopleProvider.dart' show PeopleLocalProvider;

final PeopleBloc peopleBloc = PeopleBloc();

class PeopleBloc extends PeopleFormValidators{
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

  /* Used to validate form fields */
  final _nameValidateController = new BehaviorSubject<String>();
  Stream<String> get name => _nameValidateController.stream.transform(validateNameSurname);
  Function(String) get changeName => _nameValidateController.sink.add;
  final _surnameValidateController = new BehaviorSubject<String>();
  Stream<String> get surname => _surnameValidateController.stream.transform(validateNameSurname);
  Function(String) get changeSurname => _surnameValidateController.sink.add;

  Stream<bool> get submitValid => Observable.combineLatest2(name, surname, (n, s) => true);

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
    _repository.update(item.hashCode, params: item.toMap()).then((value) async {
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

  submitNew({String name, String surname, String shortBio, int sectionID = -1, String imgURI}) async {
    _addPeople.add({
      'name' : name,
      'surname' : surname,
      'short' : shortBio,
      'sectionid' : sectionID,
      'groupid' : 0, //TODO query from configuration
      'imguri' : imgURI
    });
  }

  delete(People item) async {
    _removePeople.add(item);
  }

  update(People item) async {
    _updatePeople.add(item);
  }
}

class PeopleFormValidators {
  final validateNameSurname =
  StreamTransformer<String, String>.fromHandlers(handleData: (nameSurname, sink) {
    if(nameSurname.isEmpty) {
      sink.addError('Field must be entered!');
    } else if(nameSurname.length > 15) {
      sink.addError('Field length must be shorter than 15!');
    } else {
      sink.add(nameSurname);
    }
  });
}