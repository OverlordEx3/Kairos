class People {
  int id;
  int section; //Reference to scout group section.
  int group; //Reference to scout group

  /* people basic data */
  String name;
  String surname;

  /*  Extended */
  String bio;
  String imageUri;

  People(this.name, this.surname, this.group, {this.id, this.section, this.bio, this.imageUri});

  factory People.fromJson(Map<String, dynamic> params) {
    return People(params['name'], params['surname'], params['group'],
        id: params['id'], section: params['section'], bio: params['bio'], imageUri: params['imageuri']);
  }

  factory People.fromMap(Map<String, dynamic> params) {
    return People.fromJson(params);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'section': section,
      'name': name,
      'surname': surname,
      'bio': bio,
      'group': group,
      'imageuri': imageUri,
    };
  }
}
