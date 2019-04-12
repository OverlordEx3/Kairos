import 'package:flutter/material.dart';

class PeopleModel {
  int _uid;
  int _sectionID; //Reference to scout group session.
  int _hash;

  /* people basic data */
  String _name;
  String _surname;
  int _docId; //Personal ID. Passport, NID, etc.

  /*  Extended */
  String _shortBio;
  /* TODO Add image support */

  PeopleModel(int uid, int section, String name, String surname, int docID, String shortBio) {
    this._uid = uid;
    this._sectionID = section;
    this._name = name;
    this._surname = surname;
    this._docId = docID;
    this._shortBio = shortBio;
  }

  /* Getters */
  int get UID => _uid;
  int get SectionID => _sectionID;
  int get hashCode => _hash;
  String get Name => _name;
  String get Surname => _surname;
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
