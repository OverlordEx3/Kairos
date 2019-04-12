import 'dart:async';
import '../models/PeopleModel.dart';


class PeopleProvider {
  List<PeopleModel> People = new List<PeopleModel>();

  PeopleProvider();

  Future<List<PeopleModel>> retrievePeople() async => People;

  Future<List<PeopleModel>> FetchPeople() async {
    return Future.delayed(new Duration(seconds: 1), () => retrievePeople());
  }

  Future<bool> AddPeople (String name, String surname, int docID, String shortbio) async {
    int lastID = People.isNotEmpty? People.first.UID : 0;
    People.forEach((f) {
      lastID = (f.UID > lastID)? f.UID : lastID;
    });
    lastID++;

    People.add(new PeopleModel(lastID, -1, name, surname, docID, shortbio));
  }

  Future<void> DeletePeople(PeopleModel item) {
    if(People.contains(item)) {
      People.remove(item);
    }

    return Future.value();
  }

  Future<bool> updatePeople(PeopleModel item) async {
    var index = People.indexWhere((e) => e.UID == item.UID);

    if(index == -1) return false;
    People.removeAt(index);
    People.insert(index, item);

    return true;
  }
}
