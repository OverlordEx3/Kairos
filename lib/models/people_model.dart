import 'package:flutter/material.dart';

class PeopleModel {
  int _uid;
  int _sectionID; //Reference to scout group session.
  int _hash;

  /* people basic data */
  String _name;
  String _surname;
  DateTime _birthdate;
  int _docId; //Personal ID. Passport, NID, etc.

  /*  Extended */
  String _shortBio;
  /* TODO Add image support */

  PeopleModel(int uid, int section, String name, String surname, DateTime birthdate, int docID, String shortBio) {
    this._uid = uid;
    this._sectionID = section;
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

  /* setters */
  void set Name(String name) {
    if(name != _name) {
      _name = name;
    }
  }

  void set Surname(String surname) {
    if(surname != _surname) {
      _surname = surname;
    }
  }

  void set Birthdate(DateTime birthdate) {
    if(birthdate != _birthdate) {
      _birthdate = birthdate;
    }
  }

  void set ID(int id)
  {
    if(id != _docId) {
      _docId = id;
    }
  }

  void set ShortBio(String bio) {
    if(bio != _shortBio) {
      _shortBio = bio;
    }
  }
}
