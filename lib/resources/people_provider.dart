import 'dart:async';

import '../models/people_model.dart';

class PeopleProvider {
  /* XXX Mock */
  PeopleModel mockPeople = new PeopleModel();

  void initPeople() async {
    mockPeople.people.add(new People({
      'uid': 0,
      'name': "Exequiel",
      'surname': "Beker",
      'birthdate': new DateTime.utc(1997, 11, 28),
      'docId': "40693619",
      'profile': Null
    }));
    mockPeople.people.add(new People({
      'uid': 1,
      'name': "Brice",
      'surname': "Rivera",
      'birthdate': new DateTime.utc(1999, 11, 15),
      'docId': "45632178",
      'profile': Null
    }));
    mockPeople.people.add(new People({
      'uid': 2,
      'name': "Jonatan",
      'surname': "Diaz",
      'birthdate': new DateTime.utc(1990, 05, 03),
      'docId': "35479568",
      'profile': Null
    }));

  }

  PeopleProvider();

  PeopleModel mockPeopleModel() {
    initPeople();
    return mockPeople;
  }

  Future<PeopleModel> FetchPeople() async {
    return Future.delayed(new Duration(seconds: 1), () => mockPeopleModel());
  }
}
