class People {
  int uid;
  int sectionID; //Reference to scout group section.
  int groupID; //Reference to scout group

  /* people basic data */
  String name;
  String surname;

  /*  Extended */
  String shortBio;
  String imgURI;

  People(
      {this.uid, this.name, this.surname, this.shortBio, this.sectionID, this.groupID, this.imgURI});

  factory People.fromJson(Map<String, dynamic> params) {
    return new People(
        name: params['name'],
        surname: params['surname'],
        shortBio: params['short'],
        sectionID: params['sectionid'],
        uid: params['uid'],
        groupID: params['groupid'],
        imgURI: params['imguri']
    );
  }

  factory People.fromMap(Map<String, dynamic> params) {
    return People.fromJson(params);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'sectionid': sectionID,
      'name': name,
      'surname': surname,
      'short': shortBio,
      'groupid' : groupID,
      'imguri' : imgURI,
    };
  }
}
