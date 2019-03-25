import 'package:flutter/material.dart';

class PeopleModel {
  int _uid;
  int _groupRef; //Reference to scout group session.

  /* people basic data */
  String _name;
  String _surname;
  DateTime _birthdate;
  int _docId; //Personal ID. Passport, NID, etc.

  /*  Extended */
  String _shortBio;
  /* TODO Add image support */

  PeopleModel(int uid, int group, String name, String surname, DateTime birthdate, int docID, String shortBio) {
    this._uid = uid;
    this._groupRef = group;
    this._name = name;
    this._surname = surname;
    this._birthdate = birthdate;
    this._docId = docID;
    this._shortBio = shortBio;
  }

  /* Getters */
  String get Name => _name;
  String get Surname => _surname;
  DateTime get Birthdate => _birthdate;
  int get ID => _docId;
  String get ShortBio => _shortBio;
}
