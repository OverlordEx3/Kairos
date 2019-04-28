import '../models/sessionModel.dart' show Session;

class SessionService {
	final Session _session;

	SessionService(this._session);

	/* Getters */
	String get sessionName => _session.name;
	String get sessionSurname => _session.surname;
	String get sessionFullName => _session.name + ' ' + _session.surname;
	String get sessionInitials => _session.name[0] + _session.surname[0];
	String get sessionImage {
		return this._session.imgURI?? '';
	}

	int get sessionGroup => _session.groupId;
	List<int> get sessionSections => _session.sections;

	/* setters */
	bool updateSessionName({String name, String surname}) {
		bool ret = false;
		if(name!= null && name != sessionName) {
			_session.name = name;
			ret = true;
		}

		if(surname != null && surname != sessionSurname) {
			_session.surname = surname;
			ret = true;
		}

		return ret;
	}

	bool updateSessionImage(String uri) {
		if(uri != null && uri != sessionImage) {
			_session.imgURI = uri;
			return true;
		}
		return false;
	}

	bool sessionSectionAllowed(int sectionId) {
		if(sessionSections == null) {
			return false;
		}

		return sessionSections.contains(sectionId);
	}
}