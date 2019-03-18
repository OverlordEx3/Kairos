import 'package:image/image.dart' as img;

class People {
  int _uid;

  /* people basic data */
  String _name;
  String _surname;
  DateTime _birthdate;
  int _docId; //Personal ID. Passport, NID, etc.
  img.Image _profile; //Profile picture

//  People(int uid, String name, String surname, DateTime birthdate, int ID, img.Image Image){
  //}
  People(people) {
    _uid = people['uid'];
    _name = people['name'];
    _surname = people['surname'];
    _birthdate = people['birthdate'];
    _docId = people['docId'];
    _profile = people['profile'];
  }

  /* Getters */
  String get Name => _name;

  String get Surname => _surname;

  DateTime get Birthdate => _birthdate;

  int get ID => _docId;

  img.Image get Image => _profile;
}

class PeopleModel {
  int _peopleQty;
  List<People> _people;

  PeopleModel();

  PeopleModel.Init(List<People> people, int length) {
    _people = new List<People>();
    _people.addAll(people);
    _peopleQty = length;
  }

/* Getters */
  int get length => _peopleQty;

  List<People> get people => _people;
}
