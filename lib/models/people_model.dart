import 'package:flutter/material.dart';

class PeopleModel {
  int _uid;

  /* people basic data */
  String _name;
  String _surname;
  DateTime _birthdate;
  int _docId; //Personal ID. Passport, NID, etc.

  PeopleModel(int uid, String name, String surname, DateTime birthdate, int docID) {
    _uid = uid;
    _name = name;
    _surname = surname;
    _birthdate = birthdate;
    _docId = docID;
  }

  /* Getters */
  String get Name => _name;

  String get Surname => _surname;

  DateTime get Birthdate => _birthdate;

  int get ID => _docId;
}
