class _PeopleModel {
  int uid;
  int sectionID; //Reference to scout group session.
  int hash;

  /* people basic data */
  String name;
  String surname;

  /*  Extended */
  String shortBio;
  /* TODO Add image support */

  _PeopleModel(
      {this.uid, this.name, this.surname, this.shortBio, this.sectionID});

  factory _PeopleModel.fromJson(Map<String, dynamic> params) {
    return new _PeopleModel(
        name: params['name'],
        surname: params['surname'],
        shortBio: params['shortbio'],
        sectionID: params['section'],
        uid: params['uid']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'section': sectionID,
      'name': name,
      'surname': surname,
      'short': shortBio,
    };
  }
}

/* Aliasing */

class People extends _PeopleModel {
  People({int uniqueID, String name, String surname, String shortBio, int sectionID})
      : super(
            uid: uniqueID,
            name: name,
            surname: surname,
            shortBio: shortBio,
            sectionID: sectionID);
}
