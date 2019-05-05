import '../models/SectionModel.dart';

class SectionRepository {
	List<Section> _sections = List<Section>();

	Future<Section> addSection(Section section) async {

		return Section('', -1);
	}

	Future<Section> updateSection(Section section) async {

		return section;
	}

	Future<bool> deleteSection(Section section) async {

		return false;
	}

	Future<Section> getSectionById(int id) async {

		return Section('', -1);
	}

	Future<List<Section>> getSectionsByGroup(int groupId) async {

		return <Section>[];
	}
}