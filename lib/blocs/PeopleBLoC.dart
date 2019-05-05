import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../models/PeopleModel.dart' show People;


final PeopleBloc peopleBloc = PeopleBloc();

class PeopleBloc extends _PeopleFormValidators{
  /* Stream Controller, used to handle in/out data to the repository */
  final _fetchController = new PublishSubject<List<People>>();
  /* Getter method to retrieve all people from stream. Stream list
   * to know when some child of it changed. Or received.
   * It's, primarily, a Subscriber*/
  Stream<List<People>> get peopleStream => _fetchController.stream;
  Function(List<People>) get _addPeopleListSink => _fetchController.sink.add;

  final _addController = new PublishSubject<People>();
  Function(People) get _addPeople => _addController.sink.add;
  final _removeController = new PublishSubject<People>();
  Function(People) get _removePeople => _removeController.sink.add;
  final _updateController = new PublishSubject<People>();
  Function(People) get _updatePeople => _updateController.sink.add;

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
    _addController?.listen(_addToRepository);
    _removeController?.listen(_removeFromRepository);
    _updateController?.listen(_updateRepository);
  }

  /* Private controller listener. All magic is done here */
  void _removeFromRepository(People key) async {

  }

  void _addToRepository(People people) async {

  }

  void _updateRepository(People item) async {

  }

  /* PUBLIC METHODS */
  dispose() async {
    await _fetchController?.drain()?.whenComplete(() => _fetchController?.close());
    await _addController?.drain()?.whenComplete(() => _addController?.close());
    await _removeController?.drain()?.whenComplete(() => _removeController?.close());
    await _updateController?.drain()?.whenComplete(() => _updateController?.close());
  }

  retrieveAll() async {

  }

  submitNewPerson(String name, String surname, {int section, String bio, String imageUri}) {
    /* TODO request group id from repository */
    final people = People(name, surname, 0, imageUri: imageUri, bio: bio, section: section);
    _addPeople(people);
  }

  delete(People item) async {
    _removePeople(item);
  }

  update(People item) async {
    _updatePeople(item);
  }
}

class _PeopleFormValidators {
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