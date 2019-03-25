import 'people_model.dart';

class SessionModel {
  int _groupRef;
  int _entryLength;
  List<PeopleModel> _results;

  /* Getters */
int get Ref => _groupRef;
int get Length => _entryLength;
List<PeopleModel> get Results => _results;

/* Constructors*/
SessionModel.fromJSON(Map<String, dynamic> parsedJson) {
  /* Validate TODO add validation */
  this._groupRef = parsedJson["GroupRef"];
  this._entryLength = parsedJson["Results"].Length;
  for(int i = 0; i < parsedJson["Results"].Length; i++) {
    _results.add(parsedJson["Results"][i]);
  }

  print("Session model created OK!");
}
}