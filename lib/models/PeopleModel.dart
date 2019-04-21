class _PeopleModel {
  int uid;
  int sectionID; //Reference to scout group section.
  int groupID; //Reference to scout group
  int hash;

  /* people basic data */
  String name;
  String surname;

  /*  Extended */
  String shortBio;
  String imgURI;

  _PeopleModel(
      {this.uid, this.name, this.surname, this.shortBio, this.sectionID, this.groupID, this.imgURI});

  factory _PeopleModel.fromJson(Map<String, dynamic> params) {
    return new _PeopleModel(
        name: params['name'],
        surname: params['surname'],
        shortBio: params['shortbio'],
        sectionID: params['section'],
        uid: params['uid'],
        groupID: params['group'],
        imgURI: params['imguri']
    );
  }

  factory _PeopleModel.fromMap(Map<String, dynamic> params) {
    return _PeopleModel.fromJson(params);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'section': sectionID,
      'name': name,
      'surname': surname,
      'short': shortBio,
      'groupid' : groupID,
      'imguri' : imgURI,
    };
  }
}

/* Aliasing */
class People extends _PeopleModel {
  People({int uniqueID, String name, String surname, String shortBio, int sectionID, int groupID, String imgURI})
      : super(
            uid: uniqueID,
            name: name,
            surname: surname,
            shortBio: shortBio,
            sectionID: sectionID,
            groupID: groupID,
            imgURI: imgURI);
}
