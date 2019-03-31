import 'dart:async';

import '../models/people_model.dart';

class PeopleProvider {
  /* XXX Mock */
  List<PeopleModel> mockPeople = new List<PeopleModel>();

  void initPeople() async {
    mockPeople.add(new PeopleModel(0, 0,"Exequiel", "Beker", new DateTime(1997, 11, 28), 41637989, ""));
    mockPeople.add(new PeopleModel(1, 0,"Brice", "Rivera", new DateTime.utc(1999, 11, 15), 45632178, ""));
    mockPeople.add(new PeopleModel(2, 0,"Jonatan", "Diaz", new DateTime.utc(1990, 05, 03), 35479568, ""));
  }

  PeopleProvider();

  List<PeopleModel> mockPeopleModel() {
    initPeople();
    return mockPeople;
  }

  Future<List<PeopleModel>> FetchPeople() async {
    return Future.delayed(new Duration(seconds: 1), () => mockPeopleModel());
  }
}
