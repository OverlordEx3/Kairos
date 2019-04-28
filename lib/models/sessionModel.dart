class Session {
  String name;
  String surname;
  String imgURI;

  /* Related permissions */
  List<int> sections;
  int groupId;

  Session(this.name, this.surname, this.groupId, this.sections, {this.imgURI});

  factory Session.fromMap(Map<String, dynamic> params) {
    return Session(params['name'], params['surname'], params['groupid'],
        params['sections'],
        imgURI: params['imguri']);
  }

  Map<String, dynamic> toMap() {
  	return <String, dynamic> {
  		'name': this.name,
		  'surname': this.surname,
		  'imguri': this.imgURI,
		  'group' : this.groupId,
		  'sections' : this.sections
	  };
  }
}
